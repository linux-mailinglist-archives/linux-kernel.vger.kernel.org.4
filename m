Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F74768792A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 10:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjBBJmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 04:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjBBJmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:42:07 -0500
X-Greylist: delayed 720 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Feb 2023 01:41:59 PST
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8DD5B84FAA;
        Thu,  2 Feb 2023 01:41:58 -0800 (PST)
Received: from [172.24.5.120] (unknown [27.16.215.248])
        by APP-03 (Coremail) with SMTP id rQCowAAnLh4ggdtjMB0dAw--.22567S3;
        Thu, 02 Feb 2023 17:23:44 +0800 (CST)
Message-ID: <3e450ff5-f084-4a33-bff7-4ef1061d1f30@iscas.ac.cn>
Date:   Thu, 2 Feb 2023 17:27:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     reiserfs-devel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
From:   lujiongjia <lujiongjia@iscas.ac.cn>
Subject: reiserfsprogs: fail to build from sources on riscv64gc machine
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: rQCowAAnLh4ggdtjMB0dAw--.22567S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AFykCr18Cr1Dtw1DCrWxJFb_yoW8XrWrp3
        yfJwsxtr1ktF1fG3yxG34xWFn5A3ZFk345Xr48t34DJr98ZFZ2vF97KrWa9FW8Cr1jyw4Y
        kFZa9w1jkr1vqaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkab7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
        6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07beJ5wUUUUU=
X-Originating-IP: [27.16.215.248]
X-CM-SenderInfo: 5oxmx05qjmxt46lvutnvoduhdfq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The config.guess file contained in source tarball is too old that it 
cannot guess build type on riscv64. Please release new source code 
tarball with the latest autotools.

Full configure error output:

> checking build system type... ./config.guess: unable to guess system type
> 
> This script, last modified 2014-11-04, has failed to recognize
> the operating system you are using. It is advised that you
> download the most up to date version of the config scripts from
> 
>   http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD
> and
>   http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub;hb=HEAD
> 
> If the version you run (./config.guess) is already up to date, please
> send the following data and any information you think might be
> pertinent to <config-patches@gnu.org> in order to provide the needed
> information to handle your system.
> 
> config.guess timestamp = 2014-11-04
> 
> uname -m = riscv64
> uname -r = 6.1.7-arch1-1
> uname -s = Linux
> uname -v = #1 SMP PREEMPT_DYNAMIC Wed, 18 Jan 2023 19:54:38 +0000
> 
> /usr/bin/uname -p = unknown
> /bin/uname -X     = 
> 
> hostinfo               = 
> /bin/universe          = 
> /usr/bin/arch -k       = 
> /bin/arch              = 
> /usr/bin/oslevel       = 
> /usr/convex/getsysinfo = 
> 
> UNAME_MACHINE = riscv64
> UNAME_RELEASE = 6.1.7-arch1-1
> UNAME_SYSTEM  = Linux
> UNAME_VERSION = #1 SMP PREEMPT_DYNAMIC Wed, 18 Jan 2023 19:54:38 +0000
> configure: error: cannot guess build type; you must specify one

