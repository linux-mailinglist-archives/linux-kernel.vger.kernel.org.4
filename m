Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A70604352
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiJSLeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiJSLdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:33:35 -0400
Received: from domac.alu.hr (domac.alu.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3510C192DA2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 04:10:16 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 1319B604F9;
        Wed, 19 Oct 2022 13:07:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1666177674; bh=8sAIj8odQ5e1am9z+Vak1jaFBV8NDsFDtcsN6NQeqM8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BDOzdWBOxCZGu/SPn+efqUGOLtkUc7kZgbtB7U4ORoamurnfJVL8dzV3KJxSeaPVf
         grkMEBiNlv/aW0NOxQMqkMnkg4UO/ZuMOgKVNXjvNDxvTpTmo7OKTSFwwGQgThKthD
         qjbQfNVDEdcjH6YBqV1vz/uw4V2RqKz9AWt1MYGmaAmACcD+K7fCIGNhpx38eW0B4R
         qE4yjls853SyRSfH9hBQR6aCj4WxEvO35nZlQTcoC+TJOIk/yeNhRg/NxlPsS2OVk1
         2ZKMBld/Xr7jw9GsZDSc+mzrKx3Hjlo03FZdDzcuxnb+qZDLyNs4OhznkINEJRXaUM
         rdPq736AsUA0g==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Av5vfMaKX68O; Wed, 19 Oct 2022 13:07:51 +0200 (CEST)
Received: from [161.53.83.51] (pc-mtodorov.grf.hr [161.53.83.51])
        by domac.alu.hr (Postfix) with ESMTPSA id 0C28F604F4;
        Wed, 19 Oct 2022 13:07:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1666177671; bh=8sAIj8odQ5e1am9z+Vak1jaFBV8NDsFDtcsN6NQeqM8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dNn0CUhnc7+MLaWWTQRJfkO5rGNhFMxXQS7c3cjiGE/FhzfBKv4zvjshHIeYaD/PI
         rIezUzuyh7wr3yndTljbxMgbsHbly6rQaTKCHiGG+03PinugpCJoqFREwQqjLihV1B
         ZvFFb0IGBPjGnH1dxtZByvLhd6eWrmRqVRb2IHYxP5hc/8AjcICYb6AoAXSSLrxkJW
         BNrxHlR6zbfgR7T8xF+V7yKP/kF+KRYbM+BQpTsLGrySuwVtDKZ2ooAPseqtk+FspK
         EcCQ8gLQl7BsuX9nMbovl1Djkqtv52HIUQfNvMp2RwKFXnsFfGYgtgMEoyx1BqSbRd
         XJHL0AkmoCX4Q==
Message-ID: <74776beb-0de9-13d9-f31d-78b9fcc48d12@alu.unizg.hr>
Date:   Wed, 19 Oct 2022 13:07:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: BISECT result: 6.0.0-RC kernels trigger Firefox snap bug with
 6.0.0-rc3 through 6.0.0-rc7
Content-Language: en-US
To:     Slade Watkins <srw@sladewatkins.net>,
        Phillip Lougher <phillip@squashfs.org.uk>
Cc:     bagasdotme@gmail.com, hsinyi@chromium.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Miltenberger <marcmiltenberger@gmail.com>,
        nicememory@gmail.com,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        regressions@lists.linux.dev
References: <cfe5dd3a-5820-98cf-ae31-b6a3ff3f0578@squashfs.org.uk>
 <20221018174157.1897-1-phillip@squashfs.org.uk>
 <CA+pv=HNWZHrDBO9pp-3HoJ1qwRGaJMoZXt=iXRMUPz=-t7v8Qw@mail.gmail.com>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <CA+pv=HNWZHrDBO9pp-3HoJ1qwRGaJMoZXt=iXRMUPz=-t7v8Qw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.10.2022. 7:17, Slade Watkins wrote:

> Hi Phillip,
>
> On Tue, Oct 18, 2022 at 1:42 PM Phillip Lougher <phillip@squashfs.org.uk> wrote:
>> This diff has fixed the problem with my repoducer.
>> Please test and report your results.
>>
>> Phillip
> Tested-by me just a few moments ago and can report this fixed the
> problem. (I believe Mirsad also reported that this fixed it.)
>
> Yours,
> -srw

Hi all,

If none of you experienced machine lockup with Phillip's fix, then it 
must have
been my overload of Firefox windows and tabs, Chrome and T-bird that exposed
the bug in the first place ...

My build sequence was rather standard:

  1053  10/17/2022 05:27:50 AM  git checkout v6.0.2
  1125  10/18/2022 10:21:47 PM  cd ..
  1126  10/18/2022 10:22:09 PM  time rm -rf linux_stable_build; \
                     time cp -rp linux_stable linux_stable_build; \
                     time diff -ur linux_stable linux_stable_build; \
                     cd linux_stable_build
  1127  10/18/2022 10:25:22 PM  df -k .
  1128  10/18/2022 10:25:35 PM  git apply ../phillip-squashfs-20220215.patch
  1129  10/18/2022 10:25:42 PM  git apply ../phillip-squashfs2.patch
  1130  10/18/2022 10:26:00 PM  cp -p ../config-6.0.0-060000-generic 
.config; \
                     make olddefconfig; \
                     time nice make CC="ccache gcc" 
KBUILD_BUILD_TIMESTAMP="" -j10 deb-pkg; date

Thanks.

-- 
Mirsad Todorovac
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb
Republic of Croatia, the European Union
--
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

