Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39CE5EECD4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 06:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbiI2Ejy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 00:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbiI2Ejs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 00:39:48 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E2751A11;
        Wed, 28 Sep 2022 21:39:47 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id q9so421274pgq.8;
        Wed, 28 Sep 2022 21:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=SgLpeag8oLdNSEpmjoCYdWyQS37TeykmADfpP7CNK3E=;
        b=iwdYbvpkcy9l2triE2iPFxo6PqdYxBNviHmhT6qPXVr1uK7RcempNAF/kVYWaFkB79
         1XI7tfVoCVf8AV4m2yJHb8RP3ZIXHIY7O0ur0qfsu3tkmXh06qxuVCR474nQjxiUil+U
         pqOKfCq37y+G+57G0CArPooo6VEWBrH9bomxah7Qjwez/EZmy5JS5WvxhPSIXvmnOkOC
         rfdvMKtf6cLNyaysFTBRQHq6ijoSuOV9yCYhktA8Y+/jiDp5eG3tY9v3L1w/8WzOsptG
         2fjcRQlZlVvSFaqfNfQyrhXhqhad42hpAEuQNbjr1WfmPSWqWp3KTpH5gwzVFS57r7VA
         f3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=SgLpeag8oLdNSEpmjoCYdWyQS37TeykmADfpP7CNK3E=;
        b=seev4vZ8TZX0AAAlwKedNC9pDaprCJlwe8qB7U4WNa00sAVO1bZTevQz9dJh9B/aTK
         j1wJc/s7c/MxwNucEMySpQ+rD5rIF5uzRVaonOQc1CFikBNr1Ep+dpgx8N/vZvv6T32d
         bj555OA0S1wYLYIzKIKg4VkeCcmCB+Rig6jOH8eSdEDbC63IU7WT6L0lH/q6HZ9E7SgS
         BU4MRgjeelpFy492UQGdthNYSaVhN3tJLkOcVyue0Bp53j27BRNyL4KYgLBDSx4NK4BQ
         uFuhr0Q/sqR2kvKpCIE+KufIZ/rztV9TQ3FW1+f3ugC8pU+MAYJJdPjRtB+nqfXh5f0R
         y2nA==
X-Gm-Message-State: ACrzQf3Y0F5VX58c/4WkET5nmVJxCjc8FGy1579yyc/OePxFem1auXYx
        itvxyd6QuLAM8oXu2IQWlbhv/jTNj48=
X-Google-Smtp-Source: AMsMyM6hupqNRk49KAfTOmyKM/uFD5Tdext2tWLpVBXyqxh9vDBRI13VMVoesppy+j42g9Zu8bnYKg==
X-Received: by 2002:a63:2a89:0:b0:439:398f:cb43 with SMTP id q131-20020a632a89000000b00439398fcb43mr1210968pgq.187.1664426387029;
        Wed, 28 Sep 2022 21:39:47 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:637c:7f23:f348:a9e6])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902f54400b00176dc67df44sm4727025plf.132.2022.09.28.21.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 21:39:46 -0700 (PDT)
Date:   Wed, 28 Sep 2022 21:39:43 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v6.0-rc7
Message-ID: <YzUhj0yo9j/IUsvD@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.0-rc7

to receive updates for the input subsystem. You will get:

- small fixes for iqs62x-keys and melfas_mip4 drivers
- corrected register address in snvs_pwrkey driver
- synaptic driver will stop trying to use intertouch (native) mode on
  some Lenovo AMD devices.

Changelog:
---------

Jeff LaBundy (1):
      Input: iqs62x-keys - drop unused device node references

Mark Pearson (1):
      Input: synaptics - disable Intertouch for Lenovo T14 and P14s AMD G1

Sebastian Krzyszkowiak (1):
      Input: snvs_pwrkey - fix SNVS_HPVIDR1 register address

Yang Yingliang (1):
      Input: melfas_mip4 - fix return value check in mip4_probe()

Diffstat:
--------

 drivers/input/keyboard/iqs62x-keys.c    | 3 +++
 drivers/input/keyboard/snvs_pwrkey.c    | 2 +-
 drivers/input/mouse/synaptics.c         | 1 -
 drivers/input/touchscreen/melfas_mip4.c | 2 +-
 4 files changed, 5 insertions(+), 3 deletions(-)

Thanks.


-- 
Dmitry
