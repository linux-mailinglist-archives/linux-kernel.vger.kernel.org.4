Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B210267B59B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 16:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236010AbjAYPLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 10:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236031AbjAYPLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:11:47 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F151C5999B
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 07:11:23 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id i188so20043911vsi.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 07:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sKj8jKaS9qzEpZ/g/OHaJQRuOTXzmq7peLRAuzMOX1c=;
        b=HDJ5qm0/Fk4IPj4N4/RAkv60QIA3V+CilbE0nwMA00YLr2k7NBBZ2jvVmLUCBqUJ5Y
         1Vn4j7M45VC76cKyChHEv5FPahv6UfN+A8UEEobOYmIcDvuu6vDAUrnyZUVImAEvm3bv
         q8h/YL1qrQg7ci6bwcHv5ivJ88WgYOZjuRp0OBW0JojSnuT00iN6MNgyyyypYNnaIA/0
         wukD9CzXPDyQ8E0SSq5Y/3Z2k4MTJDYwe2P4YntkE4AqeAZLctrv+tLur+c7EZe3E6ac
         YR0NqQjq/wnF3xq00pKaCVaR2PwRkN/j11VES34mcVn0E/wPx5UUBPDOKBJPC9yJCU3G
         q8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sKj8jKaS9qzEpZ/g/OHaJQRuOTXzmq7peLRAuzMOX1c=;
        b=5hgYF7d1YajtiC6jM2YbVExOJQWZ5OGwzFXCFMOnPRsEJ7R9onbw96O4aVArVibrbM
         86QccYwDBkJOljNVjPQCKAFPiXty00fcUmpyzmTg1Risd9z+Q4FtVU1nD77C+xdxHQFI
         +cfrDSr/YNWPTcu8eQ7YdXIoDFpgelbP8lRB4Ue7ak+i5rmdCSH06b90emkSpOkzWT0R
         OUI6uPuGilAW9xRyZ+W/NXQaRypMbl+nwGUz+OTD5SZlOm60XYXlMBnZGERBNpZ6KOqT
         GKLVUgfw85cTpvOnA4PR460SxJaGtqCS6bXrq1j/uoM+K1IJxMI2cUH8VEWeUwxyKMIJ
         Z40g==
X-Gm-Message-State: AFqh2koEr5mnxUqvNQYHSMQvCEYjbqlZp6KYyzGJjTJ1WU4UX7xb71gm
        NmmP2Paws7Up19KBvOPLuMuyMuMueHn32AIBHtfUSggjWVlilgHV
X-Google-Smtp-Source: AMrXdXvbcCDG8QypkptU6Y9TFYAuhqUDoQNjsVfOwFzFHgNpOJPmg/3cmhm7ehU3nIxSXrKyvMXo1Wd5UNN/5wxEHtg=
X-Received: by 2002:a67:f2c2:0:b0:3d3:fdf4:9d30 with SMTP id
 a2-20020a67f2c2000000b003d3fdf49d30mr3817805vsn.34.1674659482687; Wed, 25 Jan
 2023 07:11:22 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 25 Jan 2023 20:41:11 +0530
Message-ID: <CA+G9fYsoGiJRYeuUpak+5aQ4Ev8s_u0YZKXMQuP7CwQsWo1G6g@mail.gmail.com>
Subject: next-20230124: LTP: shmctl01.c:120: TFAIL: after child shmdt()
 shm_nattcg=20 expected 0
To:     open list <linux-kernel@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>, lkft-triage@lists.linaro.org
Cc:     chrubis <chrubis@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vasily Averin <vvs@virtuozzo.com>,
        Luiz Capitulino <luizcap@amazon.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LTP syscalls shmctl01 test failed on Linux next-20230124 tag across all the
available architectures with following error logs,

tst_test.c:1524: TINFO: Timeout per run is 0h 05m 00s
shmctl01.c:256: TINFO: shm_id=9 maps to kernel index=9
shmctl01.c:220: TINFO: Basic checks
shmctl01.c:175: TPASS: IPC_STAT: shm_segsz=2048
shmctl01.c:182: TPASS: IPC_STAT: shm_cpid=103946
shmctl01.c:189: TPASS: IPC_STAT: shm_ctime=1674621556 in range
<1674621556,1674621556>
shmctl01.c:175: TPASS: SHM_STAT: shm_segsz=2048
shmctl01.c:182: TPASS: SHM_STAT: shm_cpid=103946
shmctl01.c:189: TPASS: SHM_STAT: shm_ctime=1674621556 in range
<1674621556,1674621556>
shmctl01.c:220: TINFO: Children attach SHM
shmctl01.c:116: TPASS: before child shmat() shm_nattch=0
shmctl01.c:116: TPASS: after child shmat() shm_nattch=20
shmctl01.c:120: TFAIL: after child shmdt() shm_nattcg=20 expected 0
shmctl01.c:220: TINFO: Chidlren inherit SHM
shmctl01.c:116: TPASS: inherited after fork() shm_nattch=21
shmctl01.c:120: TFAIL: after child shmdt() shm_nattcg=21 expected 1
shmctl01.c:120: TFAIL: after parent shmdt() shm_nattcg=21 expected 0

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Test logs:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230124/testrun/14344836/suite/ltp-syscalls/test/shmat01/details/
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230125/testrun/14356742/suite/ltp-syscalls/test/shmat01/log

Test history:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230125/testrun/14356742/suite/ltp-syscalls/test/shmat01/history/

metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: a54df7622717a40ddec95fd98086aff8ba7839a6
  git_describe: next-20230124
  kernel_version: 6.2.0-rc5
  kernel-config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2Kl19cvIBraXOcZpBGCPzCajGAs/config
  build-url: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/pipelines/755587911
  artifact-location:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2Kl19cvIBraXOcZpBGCPzCajGAs/
  toolchain: gcc-11

--
Linaro LKFT
https://lkft.linaro.org
