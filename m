Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBDD70CAE9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbjEVUZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbjEVUZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:25:11 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AA1AA;
        Mon, 22 May 2023 13:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1684787107; i=rwarsow@gmx.de;
        bh=6qv3V5j++ri4l38GYiJh91YWQ+le5HeM3xkAI85f/n0=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=jq03EAuAy70QbG1qAX0N4CqFLCXm8rx2ErEs1cbidzD+nMleQmf7N5ozlRQEaLHbJ
         tnOtgTJmL/albZKWRkRURWzFk5yR0PRgsb6ZlvlZZ/9+12iBOgLMZHpVrzXdNnXWBQ
         rMztsW4a5MQx4ByrcoVWLEZEy1p6PstxpsJuxE530v41jRwBqjkEz9hlv7g/bGhtoJ
         z+7gQUhU31/igvQT+b1AoQ1ok8MyKxYLVUK10jeIw2UieDnt8X2PJg/vDv1i1+4VuL
         UwpGBnN+p5tLu4opzXuPRrUAN33yo/OwOhlixaZrmEVlup3ifIo1QeIdQFB5XGhhMI
         lqiUSizZ2mKaA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.32.139]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mqs4f-1qVd5O1eXR-00msMI; Mon, 22
 May 2023 22:25:07 +0200
Message-ID: <947459f0-4c34-5da6-7d0b-ce1f26630645@gmx.de>
Date:   Mon, 22 May 2023 22:25:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Ronald Warsow <rwarsow@gmx.de>
To:     linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.3 000/364] 6.3.4-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:nIqSBWeOIdcRLG03lzaM67Z8Nle1VgANHnXg559AdE4Y8aG9j+T
 6Xf43pxg+x1gzqtvXUZePXfB7BaNnlW6XUNtQTk8e4BGsxe+XNit2leli4hiJGtUx05oPC8
 7QHQKGTMNlhntuGyIlXkizyVTFtvmUzwL2XB1kwkWJg5c/qj+1EpCsY7s1OI0DkMLp+pRhm
 ghxQkprF0rX5ANxpkh2xA==
UI-OutboundReport: notjunk:1;M01:P0:rKSdG3BQVcM=;Z15VB/eIFPMlUJOqdRMui97BZRU
 MEz3BpRx6cfa2wSkMkFNYEqXMMmgoOvSSJKPhgKVoPfjvNNk3C6wxm4mK9t0Cn9fnsCb/ipi0
 P3Jlt7z2Mh6Wt6URoon4mt3tYerZnE6Ajrj1gCoxLCj1VsfbnadpBoV/LdGTTEiVD3vixMiZx
 BvnW4phXksAghnN5Pc2IjDgqFHEN0CTDl5eBvVG35Jim//w4r9a/nixFPgcijBW1MO5JIsFuB
 3D/e9wsBITS8LZb4Jbb+z/rnSvcw9U/AM8UfPbPRu4D9JVKLd6l/ZjlzuxOO1Z62CXfnhqpjO
 tIP2EIlp37FISlVXJicyFSHa9Olmy4C4XBN9bxR1IU163AJBb+O26dlSiB42S2IirBctgrZzm
 UyvBEIH2gFXvXqf90+LKDyJiqC/x1Wnq3y0AZvM4ALfyG8cI04Q7Uv3dZexth66COwonTzMDG
 XMCyyXcKw1sIMN2P2payAfIjkBLXQSqpHsiNh32+Lp52C/dcB+B0xTSHfKiJqktCUszKvQe9+
 Ar6ivZcuSLr8nlS9FFBmN91Nt5V6bA9Mz00R9XYqOlqGJDlsB9Omw0pzJbLJbU9pm6X6HFNzn
 A7Qy/ThP3nWFXu2vzTOP146vo3PdQRt1Ta2JPIDEd2ts4gibQUO/Z4nRUsSLHunxBLevVCbZf
 frwfibtWqXE7esIGtS3cfIj3THHgD04V8qVyOOQ71eSVu19xd3HTDnG0RF1z7H71KoRdlSSai
 lsBgXsKEUhXklbTDLRmBcScdNrYMuv/rW2zyiQbChD5SfMUnL9Eyz/2MOGJIq3jwp/GczeSS3
 tefHqcqR9Sy8kCOBAin3eA9BkAs/lIxHa1KFA0EADN9g+xqntmHox1+D3meayehk3NHdsnPth
 DIoozljgbtpEep3bE0typzBCLv7engZrkSprqL34uS9N5aUZgvtN6jpox8xuI83KgBnhoFpzs
 AIsvui54Hv3WmqeuLB4/YhQvlZ0=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_A1,FREEMAIL_FROM,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

6.3.4-rc1

compiles, boots and runs here on x86_64
(Intel i5-11400, Fedora 38, gcc 13.x)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

