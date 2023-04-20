Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02866E8D5F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 10:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbjDTI5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 04:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbjDTI4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 04:56:38 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFBC5B9A;
        Thu, 20 Apr 2023 01:54:40 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l31-20020a05600c1d1f00b003f1718d89b2so2729256wms.0;
        Thu, 20 Apr 2023 01:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681980879; x=1684572879;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/1nmSJoHao2Xv1R5LLZFmg+3N6nON3bsre5f7/ykalM=;
        b=ljIHPQzFFyGCCB+FF8NH25LiqxPEUydxxqg1xk+LKKlyGT4Ud2+0oMPplY5MeneGsk
         f5OezBCDawk+vMjooGD9xhaT6nRmOkckJ5JvF0kzGrgAF0TCrCNdORM8bcNXbTBAjVcZ
         vPo9cOulmWmC5CX01K3EXm4JLtj0SFYaiWvV3dVb6ddJrM6kCmnJHu/4x1c3VvXl/SEm
         WMdCMl/VnDL8pNxY8t6UC8QCqZCJKqzDx2YdFXpSGcbCBAdGHf2zgDWSyqvO8SYLId9u
         Hnc0FIa0dUKQACQitFKjDEg8F7SLsnL9CtLR4pDOoMy1tXUTrzu/I05hjCf30jLC8QVt
         ClaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681980879; x=1684572879;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/1nmSJoHao2Xv1R5LLZFmg+3N6nON3bsre5f7/ykalM=;
        b=Z8sJCC+Gbj7cK2Gewrl6sIjyKGBiTzdS5BLiYNHR8Y1/s4JI+n1Ngu3dJvKsMgaj1J
         YI5H7iU7qpntf7xeo/HvmySbdU7mVZ7b30Jgk4FfE5Q2QV//e7rDN7KKOoBZ33BQHvyg
         7SdbdzZZfZzKlHsi/NSNj8Pi7+19/3PM+zKajOc0/pmS5WYbBTqn4Urcl5i2bhViJK5I
         MXOUWzaIXdJo9ukTzudiQJ6xY6IEsEFntdFAcQWl3AmjVoSGzctMRtGQznyjczQCAqGo
         IxGASXDH3bOFp90I/MbVKgjKApZafVvSHjau3Lxk3c2S4656VkpKUT3S3FuQP0EFxMrp
         Mvvw==
X-Gm-Message-State: AAQBX9e9jh9IU0UdcMshtsR+ZtiRQzcGlP4cnq42R+7vJjbdjTCJDCCa
        YpCNE9lfgG8i7QyoMu46624=
X-Google-Smtp-Source: AKy350ZV27kPTUXFD0SUn95Kojy7v+U1CO3Ru4rd5bSoHUPQF0mBJTsTaFjwtiB4bcjKWdbqooEcEw==
X-Received: by 2002:a05:600c:ac6:b0:3f0:9cc6:daf0 with SMTP id c6-20020a05600c0ac600b003f09cc6daf0mr763257wmr.27.1681980878656;
        Thu, 20 Apr 2023 01:54:38 -0700 (PDT)
Received: from [192.168.0.103] ([77.124.103.108])
        by smtp.gmail.com with ESMTPSA id g10-20020a7bc4ca000000b003f171234a08sm1360668wmk.20.2023.04.20.01.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 01:54:38 -0700 (PDT)
Message-ID: <a42a2dc4-bcbc-7a19-b036-8722606a5eaf@gmail.com>
Date:   Thu, 20 Apr 2023 11:54:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 3/3] kbuild: do not create intermediate *.tar for tar
 packages
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Terrell <terrelln@fb.com>,
        Nicolas Schier <nicolas@fjasle.eu>, dalevi@nvidia.com,
        Gal Pressman <gal@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>
References: <20230407101629.1298051-1-masahiroy@kernel.org>
 <20230407101629.1298051-3-masahiroy@kernel.org>
 <20230407181223.GD1018455@dev-arch.thelio-3990X>
From:   Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20230407181223.GD1018455@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/04/2023 21:12, Nathan Chancellor wrote:
> On Fri, Apr 07, 2023 at 07:16:29PM +0900, Masahiro Yamada wrote:
>> Commit 05e96e96a315 ("kbuild: use git-archive for source package
>> creation") split the compression as a separate step to factor out
>> the common build rules.
>>
>> With the previous commit, we got back to the situation where
>> compressed source tarballs are created by a single rule.
>> There is no reason to keep the separate compression rules.
>>
>> Generate the comressed tar packages directly.
>>
>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> 
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> 

Hi,

We started seeing the failure below in rc7.
We narrowed it down to your patches:

3c65a2704cdd kbuild: do not create intermediate *.tar for tar packages
f8d94++c4e403c kbuild: do not create intermediate *.tar for source tarballs
f6d8283549bc kbuild: merge cmd_archive_linux and cmd_archive_perf
aa7d233f45b4 kbuild: give up untracked files for source package builds

Can you please take a look and advise?

Regards,
Tariq

[root@c-237-113-200-203 linux]# make -j24 rpm-pkg
sh ./scripts/package/mkspec >./kernel.spec
rpmbuild  --target x86_64-linux -bs kernel.spec \
--define='_smp_mflags %{nil}' --define='_sourcedir rpmbuild/SOURCES' 
--define='_srcrpmdir .'
Building target platforms: x86_64-linux
Building for target x86_64-linux
Wrote: ./kernel-6.3.0_rc7+-1.src.rpm
rpmbuild  --target x86_64-linux -rb kernel-6.3.0_rc7+-1.src.rpm \
--define='_smp_mflags %{nil}'
Installing kernel-6.3.0_rc7+-1.src.rpm
Building target platforms: x86_64-linux
Building for target x86_64-linux
Executing(%prep): /bin/sh -e /var/tmp/rpm-tmp.yDFEga
+ umask 022
+ cd /root/rpmbuild/BUILD
+ cd /root/rpmbuild/BUILD
+ rm -rf linux
+ /usr/bin/gzip -dc /root/rpmbuild/SOURCES/linux.tar.gz
+ /usr/bin/tar -xof -
+ STATUS=0
+ '[' 0 -ne 0 ']'
+ cd linux
/var/tmp/rpm-tmp.yDFEga: line 37: cd: linux: No such file or directory
error: Bad exit status from /var/tmp/rpm-tmp.yDFEga (%prep)


RPM build errors:
     Bad exit status from /var/tmp/rpm-tmp.yDFEga (%prep)
make[1]: *** [scripts/Makefile.package:69: rpm-pkg] Error 1
make: *** [Makefile:1656: rpm-pkg] Error 2
