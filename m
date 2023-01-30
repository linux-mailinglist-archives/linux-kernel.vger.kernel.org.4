Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2A4680849
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 10:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236143AbjA3JOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 04:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236130AbjA3JOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 04:14:45 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D34241C3;
        Mon, 30 Jan 2023 01:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1675070077; bh=s8AkH4O6tZzfz+r4vJLuBJMfjtu256PBbhMH/jEEhxQ=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=hBMAvF2hsLmR2cLaLbotJ51Zrh2bJe3+5JkfZl9W2/s9wtlQTsXKGhUwhwy58Ro+5
         P65dZKCmsYJ164aj6HEk4/z4kykzanJ13saN/5G0v9OWCBZsH0IxUOV0h9HSk0WDkB
         MdxqF6DNpuQpFGmGjGmf62yR5jNHEGhAlUZifIPOWdcWkbWqDd+fEkNmHExzHg1N0J
         oqm0COjkRldmDgo5LP235IvfNevI9tMKk2IZevuD0tamDlmAViVtnTIbOBbe8BTXfo
         qkqcVIf6uw4CnccUih7AkSO99Wz4YhFCnMImsT1yDU+14OI+Hfhs6sHQSj+9oadu/F
         IT/i/jG5UR8Mg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWigq-1pBXBV2kBc-00X6Ue; Mon, 30
 Jan 2023 10:14:37 +0100
Subject: Re: [PATCH v2 0/2] ACPI: battery: Fix various string handling issues
From:   Armin Wolf <W_Armin@gmx.de>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230119142115.38260-1-W_Armin@gmx.de>
Message-ID: <8e3ddde5-87aa-a72a-dcfa-5a6041377b15@gmx.de>
Date:   Mon, 30 Jan 2023 10:14:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20230119142115.38260-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:9g1ZHK6rzJeww0WSSbFMBOgqn7oUQCKJ4XU3fehMP2/zw59c9xR
 WmIvJ3iSPT49v7vCCUU9lmIKnqvYSjbqK0o2t2WDIp3gGEvLu4Qc7hvTh6rsiztmZkS0FHQ
 MuiHfcw/LoKLG5XnYKmhETo3rZ4Nt6lrusQfSaXsFJ4Nq8C9jH9fFk2OSbOxmDD1780bSzX
 fhXOG+L+CQ997m5r8DfMA==
UI-OutboundReport: notjunk:1;M01:P0:NYzVJkqPI44=;SIvQM7tfF3nnAr4gZrV1SSI/f5A
 ZmE00yrppY82SyH2kRzoJNFpAlnpGFRQkagd6p62JInsPnt2H7tJE98VGPKWp8ipkpEL3xu2V
 1YFl6l/2XVL10Fl1xce8EW/u19Ta47sjveswxePL+iaGVyZaSdBBRncuyTU7Ui/qf4CQtFF4F
 yyEkte6UhJJ2/hcO381t0WUgN7Izu49JIVCpI9z73m5aI+RojrjW7boE7NU25z1FXnHMjsr8P
 t7ANeDxx11SfR+MqazgcTFj36b8Pr0XezXQPcSigMIgt2T/BE6i8nyCnXMGat1ugVTGsS3sGT
 3wqfj8L4pwnJUgaEp7Bw8XrqmKaNnpHjSiXSmYhJw5nwW1zS1uP4PukJrkyzb9WKNLoaHOuiF
 0nHmgx6U31FC0VlbEhEy/R8HxmR0vFhH/RNWPI0cdONoZslYPapaNPQgRyQL3wBS9/WzoAmiw
 31umQiXw396KLwatAo+r8blkm8N/Ns7n6WdJiguxhVUSsXmbFKqR6cvczwtlahvPXSBaOesjY
 GnOEbWjzku+kA9H7nCzB4LHTBgGGItb/CIDkD5A2Rhca5yv60iYcsqx8VheDVFEoEYnxm5rTQ
 x7AKpY5gxiUAA4p1J/wDGmkCAHGCJjAIFIcJgsxrUclyycJZI7JC0BMgtjtbnELdGionYKIu5
 ubL4WI6i9A9bp03sgoFIu2XLBTA/EQGkp1nfEnW1zOdf5WSYoPRkIWRUQHh3XafRsKy8tCqH+
 q2INYzhstfNXD0c1Q1F0Euj3uRSaU2x60CoeKK/DR/ZV+kBO/YIK+u0gNh2BaN64t+QelEr6B
 LK7BeY3BDBd1N2RsZYuXCrG4ttqQVvSJQmQxrUBnH2yNtnjr8xjmKWAfud/Svzev39QPXUTP9
 fFOcHGASMX2dfo4kqj5gjPZEJ0/Ys4MyUQrnHwWydyFXgFAHQDqUmZpdUCi4SnupZS0bNmEkA
 ue804AlsjwXHsrpdf5Sqhl4dl5c=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 19.01.23 um 15:21 schrieb Armin Wolf:

> On my Dell Inspiron 3505, the battery model name was displayed
> differently than when running Windows. While i first suspected an
> ACPI issue, it turned out that the real reason was the ACPI battery
> driver failing to handle strings larger than 32 bytes.
>
> This caused the model name of the battery (35 bytes long, hex string)
> to miss proper NUL-termination, resulting in a buffer overread later.
> Luckily, a valid string was stored right after the now invalid string,
> appending only the battery serial number to the original model name.
>
> The first patch fixes a potential buffer overread then handling buffers,
> while the second patch finally increases the maximum string length to
> avoid truncating such larger strings.
>
> The patch series was tested on a Dell Inspiron 3505 and appears
> to work properly.

Are there any outstanding issues with the patch series which need
to be fixed for mainline inclusion?

Armin Wolf

> ---
> Changes in v2:
> - Drop first patch since it was already applied
> - combine the second and third patch
> - do not replace 0 with '\0'
> - spell ACPI in capitals
> - rework the buffer length hdanling
>
> Armin Wolf (2):
>    ACPI: battery: Fix buffer overread if not NUL-terminated
>    ACPI: battery: Increase maximum string length
>
>   drivers/acpi/battery.c | 35 +++++++++++++++++++++++------------
>   1 file changed, 23 insertions(+), 12 deletions(-)
>
> --
> 2.30.2
>
>
