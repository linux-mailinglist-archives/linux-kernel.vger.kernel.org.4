Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA07C664FF0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 00:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbjAJXZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 18:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbjAJXZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 18:25:22 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825244087C
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 15:25:21 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id y205so2364159iof.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 15:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OFIDCF8/FPWWdWRSXR8nb5Nq0BhKi9qve6Lh7qX07dc=;
        b=S0eTHoD3jfHH+ZJKPbFjVIE1w9cmkpAHTiyo0/5vJPDSsm2ot7G5BRKxjSO5v7wo4j
         UAIIeF1yCzTA+2qTFkEdSl86ctnVwKPbR79MiH/hDiMcM1CTVyWHNEBX8emimyMzg5rq
         wrHqCn0bqEl1FwRRc3Tmgc9mevAkwCM1iKq+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OFIDCF8/FPWWdWRSXR8nb5Nq0BhKi9qve6Lh7qX07dc=;
        b=4UMqGtniuLOo+Q63TiU284YEnhqBdrl+EB3qxDL/vriLty6w2SIBeAPt5xAUyzYwOW
         dd6IF+tEs7TENvVwZSeapllIESo2GjQd1Lf1jqWAUlSbMEoUifrWeog5emvthhOodkUn
         tghdCdM/uolRx5Xu0SSs+01B7j5xGF3S33euGmwfk9zFzavZlNoYVdptpmpKVGmyAWlJ
         e7zxBHVm6UhlFvfmE6VMx+hSI3Ixt2vmBC8A5Jqxb4u0cbU1VsAijitGA3zwsbIjiXPa
         UnI9jsETf3VC+3MIy6w2mNAJyfl3T+iZMZ2QK3PjGGT8coQjhLqeTzd+8ThjY8k6kCu3
         +rfg==
X-Gm-Message-State: AFqh2krccBXEWHay0JkBz4kxg+HAOqv4Zlgm6ak99ztsx6Fs38Tx0w7Z
        HZetHlIPPfYWiIg5LittaT36wg==
X-Google-Smtp-Source: AMrXdXtecdi+P+sa3s+zZAtVCYJm0YnT0KYEqkkdqWJodnXG2SpApa2kFeSANjwNcsctpz7N5bI49Q==
X-Received: by 2002:a6b:7d46:0:b0:6ed:1ad7:56bc with SMTP id d6-20020a6b7d46000000b006ed1ad756bcmr10474215ioq.0.1673393120751;
        Tue, 10 Jan 2023 15:25:20 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id s28-20020a0566022bdc00b006e038a2f29dsm4457059iov.13.2023.01.10.15.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 15:25:19 -0800 (PST)
Message-ID: <0164d8af-65f8-d3a4-c8c2-568f1806e147@linuxfoundation.org>
Date:   Tue, 10 Jan 2023 16:25:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] ver_linux: add missing software to checklist
Content-Language: en-US
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20230110204225.35503-1-skhan@linuxfoundation.org>
 <Y73qkkf0MZAvJCNN@Gentoo>
Cc:     Shuah Khan <skhan@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <Y73qkkf0MZAvJCNN@Gentoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/23 15:45, Bhaskar Chowdhury wrote:
> On 13:42 Tue 10 Jan 2023, Shuah Khan wrote:
>> Update to add missing software checks to bring it in sync with the
>> Documentation/Changes list. Make improvements to the output with
>> separator between different sections.
>>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>> ---
>> scripts/ver_linux | 29 ++++++++++++++++++++++++++---
>> 1 file changed, 26 insertions(+), 3 deletions(-)
>>
>> diff --git a/scripts/ver_linux b/scripts/ver_linux
>> index 1a8ee4ff0e32..6131f6f1b35b 100755
>> --- a/scripts/ver_linux
>> +++ b/scripts/ver_linux
>> @@ -6,10 +6,14 @@
>> # differ on your system.
>>
>> BEGIN {
>> -    usage = "If some fields are empty or look unusual you may have an old version.\n"
>> -    usage = usage "Compare to the current minimal requirements in Documentation/Changes.\n"
>> +    usage = "Minimum required software versions to build and run current kernel version.\n"
>> +    usage = usage "If some fields are empty or look unusual you may have an old version.\n"
>> +    usage = usage "Compare with the current minimal requirements in Documentation/Changes.\n"
>>     print usage
>>
>> +    separator = "===================================================\n"
>> +
>> +    print separator
>>     system("uname -a")
>>     printf("\n")
>>
>> @@ -17,9 +21,15 @@ BEGIN {
>>     libc = "libc[.]so[.][0-9]+$"
>>     libcpp = "(libg|stdc)[+]+[.]so([.][0-9]+)+$"
>>
>> +    print separator
>>     printversion("GNU C", version("gcc -dumpversion"))
>> +    printversion("Clang/LLVM (optional)", version("clang --version"))
>> +    printversion("Rust (optional)", version("rustc --version"))
>> +    printversion("bindgen (optional)", version("bindgen --version"))
>>     printversion("GNU Make", version("make --version"))
>> +    printversion("bash", version("bash --version"))
>>     printversion("Binutils", version("ld -v"))
>> +    printversion("pahole", version("pahole --version"))
>>     printversion("Util-linux", version("mount --version"))
>>     printversion("Mount", version("mount --version"))
>>     printversion("Module-init-tools", version("depmod -V"))
>> @@ -28,6 +38,8 @@ BEGIN {
>>     printversion("Reiserfsprogs", version("reiserfsck -V"))
>>     printversion("Reiser4fsprogs", version("fsck.reiser4 -V"))
>>     printversion("Xfsprogs", version("xfs_db -V"))
>> +    printversion("squashfs-tools", version("mksquashfs -version"))
>> +    printversion("btrfs-progs", version("mkfs.btrfs --version"))
>>     printversion("Pcmciautils", version("pccardctl -V"))
>>     printversion("Pcmcia-cs", version("cardmgr -V"))
>>     printversion("Quota-tools", version("quota -V"))
>> @@ -36,7 +48,16 @@ BEGIN {
>>     printversion("Nfs-utils", version("showmount --version"))
>>     printversion("Bison", version("bison --version"))
>>     printversion("Flex", version("flex --version"))
>> +    printversion("Grub", version("grub-install --version"))
>> +    printversion("mcelog", version("mcelog --version"))
>> +    printversion("iptables", version("iptables --version"))
>> +    printversion("openssl & libcrypto", version("openssl version"))
>> +    printversion("bc", version("bc --version"))
>> +    printversion("Sphinx (for doc builds)", version("sphinx-build --version"))
>> +    printversion("cpio", version("cpio --version"))
>> +    printf("\n")
>>
>> +    print separator
>>     while ("ldconfig -p 2>/dev/null" | getline > 0)
>>         if ($NF ~ libc || $NF ~ libcpp)
>>             if (!seen[ver = version("readlink " $NF)]++)
>> @@ -50,12 +71,14 @@ BEGIN {
>>     printversion("Sh-utils", version("expr --v"))
>>     printversion("Udev", version("udevadm --version"))
>>     printversion("Wireless-tools", version("iwconfig --version"))
>> +    printf("\n")
>>
>> +    print separator
>>     while ("sort /proc/modules" | getline > 0) {
>>         mods = mods sep $1
>>         sep = " "
>>     }
>> -    printversion("Modules Loaded", mods)
>> +    printversion("Modules Loaded:\n", mods)
>> }
>>
>> function version(cmd,    ver) {
>> -- 
>> 2.34.1
>>
> Hunch....
> 
> One, is grub required to compile kernel?

These are minimal requirements to compile and run the kernel.
Running requires installing it first and install tools are
required. grub is listed in Documentation/Changes.

> 
> Second, can we please stick to " absolutely required software" than showing optional??
> 

This is an attempt sync this ver_linux with Documentation/Changes
and print out complete list which includes optional.

> Separator adding is good one.
> 

thanks,
-- Shuah

