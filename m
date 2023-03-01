Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22796A6683
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 04:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjCADfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 22:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjCADfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 22:35:06 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0522F158B2;
        Tue, 28 Feb 2023 19:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1677641688; i=deller@gmx.de;
        bh=8OkoU8cjjnK9Q/9coj+yH8pVTcCm2axDAtuI5lLPgzc=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=rpCuRIXYVdO7Ahseksf1r0bjW6C5aA1saY8zzW+cscYB865vnJB8KKPiDtJp2LDdI
         ukfyL6sZcFUdiKYoVN8yRxcDkFCGw8pLFxlkbCNLDzrojITdQdcGPuH7hwer6bXwCj
         gBeroKb8yUdy862ahL3LgqOOwC4GXj/QzRIzYrZ4wXn2we9GkJqqdQBHTk5r4wfA6t
         6BGG4utA6xKeSCdWr3FczIewHEtEFTQbAGW6xMvKa4EahoHZtW6XfNvPdIbqBAQHCM
         +LlG2XXc4YWH/1e0uAwK2E6dtRywN/enmmzlPkZqe1YdzN9S8Ais2QHiiNHJES6Rfw
         9ytIJm1AVtX7A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.156.241]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVNAr-1p5OhD0pAl-00SPZR; Wed, 01
 Mar 2023 04:34:48 +0100
Message-ID: <b675efb2-19ac-ac2b-a86d-98b2c2841956@gmx.de>
Date:   Wed, 1 Mar 2023 04:34:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: linux-next: duplicate patch in the input tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Parisc List <linux-parisc@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230301101303.2223f88e@canb.auug.org.au>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20230301101303.2223f88e@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7inPa2jI6RsHckThtPhRCE3WKUN6totvxkvZvL16kxoAG8UDpou
 iuwxudD9v4dUXTy5JbyP0eNhkbj1ctazgXfLRtNlALaaYk6uXb49EV+OWeSdgfmYLhKIqSr
 26xTUyxz5bZufJMpHVbiH9mdMqNbQcSYCD0jiPkmlnjN/TKDb/ZCpwHE/c9nS+JBi41BeBp
 5mteq8/zRzbRsmEIDhmNA==
UI-OutboundReport: notjunk:1;M01:P0:Y1Sg357+EMU=;y95p20mO1WcwbHqgRSAMphOJ3Z4
 FqxX7tMcuSe5LcJqUcHJnmuahYE5mVjTZi/0SqMQ4gxITnC48yt6zu54qdIVfB+aSJzxan5Wh
 ScAWtwAUJJCuowIN6+xTBELXs3H0DcEkLMrpwEAxgZ64m7Dvr3Qwtj49+TwpiKjPQ0QENGG4K
 b40LmvWpRdGfBQAsh4ho1i9Y1FYTLJUbj3EEaX9mT+piIkRs3lZ5ImI+B5p1DKRjmQhdbddrR
 6hZWsgs/AYk9hOdJ8D0MnMPxpg2CS8SYaJR2UHTJezZrV0GKDvWvFrfhALQDtQLrVjbWhrSog
 uCYgfFSs0ETwj8kgBcpR8u01ce/Yl8K5bI1ALKo6S1OKMfky21IZ9JpSXxmrbidHSxIElw60t
 QDI5JFAZvW7/AadPe7e7+KvuA9/0rv1MqYxGV5OhHb4YjJO/0LTZ9XqH7wLAcJbZxg0lm/1sg
 vQH5jvq9OULZ6NX2GJlTY1YOyluVSmolSyHfNE1Lj2jKhJky+prjdFQadS10C6EYohoOoqyq1
 tUI5IJcyCSPMZGQjAYY2rWItUxv5Pwn9Z9yTk3I5wStlivrL/GCPXGi2zdoKPWODf+gUGDjxY
 stTVXhSZRTas0REFLXRY/mWQg3stpMjhEP2TwBesrC467MoEtrZFeQDAgD2S4zTAEpjh6hGr5
 w5YgYexTXtJfqDEIrLAWICFpt4odH9ftn4k4Zc2zICw8IbCdyNvWh6j1/FV2flPVSSuRDzPLu
 twQOyBbD6j7ZDnWSnyD/Gln2HoSiXb75C8qmjCoSp9hPkvAoEdAEhS06lzTGPFK+UJsuzettE
 yzQV3jbLYilGeXxTfRVcVnSTheZwauTG2ZKWYqA5zu29qogPumGI+bHDIw1as+ppvxDHOR3+F
 q30FM75zKWO1TZHwL4/5Uia8GRO7eBwuyYgpsijbLMeOY3FFaQQy5abwwrriPTm4JkLvno81a
 WfSEvJ4VeRcKMHw8uhDBI4uBisA=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/23 00:13, Stephen Rothwell wrote:
> The following commit is also in the parisc-hd tree as a different commit
> (but the same patch):
>
>    586dc36226dd ("Input: hp_sdc_rtc - mark an unused function as __maybe=
_unused")
>
> This is commit
>
>    ab898955932e ("input/misc: hp_sdc_rtc: mark an unused function as __m=
aybe_unused")
>
> in the parisc-hd tree.

I've dropped the patch from my git tree.

Helge
