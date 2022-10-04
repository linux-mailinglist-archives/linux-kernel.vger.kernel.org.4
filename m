Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534C35F3D40
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 09:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiJDH3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 03:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiJDH3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 03:29:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F929EA1;
        Tue,  4 Oct 2022 00:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664868556;
        bh=PjLfiWf3KgvvxLs7ixsr6WIV11sUjNekWvCmpbR/84s=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=fb48HmkZm5vTXDmpGRqodbdTJwXh/UE+KDb2e5QoB0UrLuwKTaExfV8RG/+v30+Ss
         kaEYFAYw0qTyWcGSxwYVXYWHFx4KTJY5ljNy4JQqd222qZc5JhjyGS0pqoJJam7gPA
         I7urxg0X3yq0u9mtLlNqnKZIFmv9Rp4L1emUlW54=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.170.54]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSKu0-1om7fP3EPw-00Sgwp; Tue, 04
 Oct 2022 09:29:15 +0200
Message-ID: <9e45b60b-4af5-4fed-7b7d-3a5c4dcd6321@gmx.de>
Date:   Tue, 4 Oct 2022 09:29:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: linux-next: manual merge of the fbdev tree with the drm tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Dave Airlie <airlied@redhat.com>
Cc:     DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        ruanjinjie <ruanjinjie@huawei.com>
References: <20221004132723.7b4b03ab@canb.auug.org.au>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20221004132723.7b4b03ab@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RhRjjdSTMXclbO2Pq+jAsOtH6f8ahvH3qxxv5b3ySNGrbPxD1PA
 cbANWDIDwujW/Okg1nuRjcdfvBOp/C4DxaoZoBX8x7aPOzcRvWAHvsn1o1jt2GXrc2Xz+Ae
 FMWzqgpffhhp90IJY0aePAzVt6AxafuMS0J0o9ZZcH5npnqZ4nbQvwizezgrbiyDW3lMlCc
 xdZSemk8WrJE3S5Yax0xA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kPdXvwEittw=:MHpYa29j3z0JvMBwkVigz5
 fYR3szZUEaW9U+lLDO3ycDKvyF5LfE+b45CQCBRhz0gQJXfIYeKHRM1/LKRhBsw+kOt74Eqio
 J41IWSL1nY3oVmYBCLK9C3s+eQO3MU0PrhTI09owiJTAPuM4fGPTgp1MqTaLFKPULQOcAkPIA
 aySe80F/R+gwqD/ZZms2K3lbHPUv4OoRfehdppGFLxIxyPgMI/JPJVWPLoPVWtNUW/IZe2dMr
 DVZQEPTkTW5hVaP0No5en96GC2I4tRRLgIrZ7VojgBH0rZqJ7l7gCmAn/JxEkV1elGx3Ud/UT
 KOHCkws1Bc2jR4QYhSZLbUDzlpN+qs+gD2dQTBgTL1BDSgii+E6Jp4WQcP5dmU5/AulLQjoHt
 /6JR8NgkAXk5AsWORnU+37c6ulYnrunZ579TdAvW5PHaN7TOKAsQJ6MxO7MlP0oFo+JJOQ1/G
 LmuJWflYn3ioIUnuEGctkkyn0r778U8Q9KHEKr4zgK/GW2qjW3F5UprJobSlZUYXa7IWgAZ0D
 sDK7jgaSRyyN3b7dIO3bsofHf7+P1DVIM5qI2tOBtrcgxX3IuTpUB1CfBkrqxgZ4ktX/mBWjN
 dezuK0eJ7QpA/enn16k5bdFPOmLerVEHodbhr6CWGKdapP0h5j4FstA4lwUkK2lYRD7vRbylr
 J1axNKo+57YkYcbY3pfj7SGttvw5t+/Mqp/rcXxUBZZO0u1hobQOMX83vKCbKkhTJ9W2+Sl5v
 boeLh3usjOek0Pm7ToEI9l7BYCE5dcSMIY3BY4l5HvhRuSWdTx3X89dphMlrp7ZQ97VIyBuJ0
 GbP3Jd+U17UsBlrcnRm0tQwUzLXpVmG976s633D6AnTDXouOuXcNA2dG6Ql08MHuHhgNqvmnk
 6PkKioDBAUrOtbI5r2fiHcop/k9WRBkY9Tz4/MRQstfS8YrrBPYESSjx0OLKYJAIGl6B2sMh5
 Y8vriAAt9icI/gcbMWWqD44AH+/5G2b9XXfeoBmpEdGxu/B+Ad2t/T826b90rc1yK8EtsDZTx
 ZA/3JeyrGxx/dQa3xEYo+v4Ntgy4OGyEisbcqB6KmxdFb3sqps5CZ3FZCLjvqN1jJuodQtKAu
 iTQKJguSi6aULE+hYZuUGGt4MGmU2mO7fsH35MmRCXa9lEEn9UpWcNr434jrkWxPUVH7LLVhW
 HCXOHL4mK+lXaQV96hu1Un16pt
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/22 04:27, Stephen Rothwell wrote:
> Hi all,
>
> Today's linux-next merge of the fbdev tree got a conflict in:
>
>    drivers/video/fbdev/tridentfb.c
>
> between commit:
>
>    145eed48de27 ("fbdev: Remove conflicting devices on PCI bus")
>
> from the drm tree and commit:
>
>    d738bf0123d6 ("fbdev: tridentfb: Fix missing pci_disable_device() in =
probe and remove")
>
> from the fbdev tree.

Thanks for the notice!
I'll fix it up in the fbdev tree, either by dropping that offending patch =
or fix the conflict.

Helge

