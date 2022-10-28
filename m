Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0A0611C7C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 23:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiJ1Viu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 17:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiJ1Vir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 17:38:47 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5704F1E392E;
        Fri, 28 Oct 2022 14:38:44 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 3439F3200906;
        Fri, 28 Oct 2022 17:38:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 28 Oct 2022 17:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666993120; x=1667079520; bh=8Yisrc4t5YOzlKTteyDamj2L+fWA
        0otx8SfL5TIDAj0=; b=pFDXJ4AJW615LHQ7Br/ztk4nIoBWPZZTMnx5g4HIqREo
        PO4w+VdMgBSy5wZE4OcGed+mKMPM8lwsG+aNa/E/A+uvPImyjIDa1JVVRwaAziS0
        yXodtmoyD+k2ClyaJlYvohB0Q3VGeNyytS7mRNLf1c+hf1o6t3yOkv8j4/iXRfhd
        JgU4ue+RXlWcEpAB8tJC2YDaQCT4KRo7IWSkFPCP3mrVMZqF7Q3jAEZxbq5uzPC5
        cdLWIywzRudI+vHarT94rU+1iWNKIP8R1CEO6pOiQCXae5BxXF7nm3gW0S3eAWKQ
        Y/S8zOA5CxIMZy358SFxVmr1QcN0Eghyc8jsQ9GazQ==
X-ME-Sender: <xms:30tcY41WGwv6s74tG6-gezR0hCrpm5GhJS2fR6F_PTEB7k4doSZBmQ>
    <xme:30tcYzGkWKJQVLHXUZDE7D0FJqu5znBOSPpe-vSDwSRrzGw1a46acg-CuqwQYOH8x
    ti4TG7wyMOl-I6oQhs>
X-ME-Received: <xmr:30tcYw5HzpU5DPzQVofAfRhbA1HTqR8mrEUQndSf8Ots8eGCigJpwwgJ19ciVdoeQCm81eFv_jbOQ4naHbZjdAX1N8tSSXV2vTI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtdejgddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfv
    hhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrth
    htvghrnhepleeuheelheekgfeuvedtveetjeekhfffkeeffffftdfgjeevkeegfedvueeh
    ueelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfh
    hthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:30tcYx1BdgaH7GdbSTgiitiBg8AJbB3j7T00lmQJ-TpM7-v4bjGInA>
    <xmx:30tcY7GL2WdztjvmAlOBAfbFt5BtHdKNZ4MAF0vjMZcvSKUlslpETQ>
    <xmx:30tcY68cNHEf6JMNy7GymZwRqDempOpkBDIqEtqWE4ikTIMQhn1U9A>
    <xmx:4EtcYzDJe7G7c8-CywjPGQ6ROlTFIH0-3dihDjnpZg_t0N1Wjapm1A>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Oct 2022 17:38:37 -0400 (EDT)
Date:   Sat, 29 Oct 2022 08:38:50 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Jilin Yuan <yuanjilin@cdjrlc.com>
cc:     schmitzmic@gmail.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: NCR5380: fix repeated words in comments
In-Reply-To: <20221028133708.60030-1-yuanjilin@cdjrlc.com>
Message-ID: <142f436e-2534-4c00-0fb2-0f385e404856@linux-m68k.org>
References: <20221028133708.60030-1-yuanjilin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Oct 2022, Jilin Yuan wrote:

> Delete the redundant word 'the'.
> 
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>

Acked-by: Finn Thain <fthain@linux-m68k.org>

> ---
>  drivers/scsi/NCR5380.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/NCR5380.c b/drivers/scsi/NCR5380.c
> index dece7d9eb4d3..ca85bddb582b 100644
> --- a/drivers/scsi/NCR5380.c
> +++ b/drivers/scsi/NCR5380.c
> @@ -858,7 +858,7 @@ static void NCR5380_dma_complete(struct Scsi_Host *instance)
>   * latency, but a bus reset will reset chip logic. Checking for parity error
>   * is unnecessary because that interrupt is never enabled. A Loss of BSY
>   * condition will clear DMA Mode. We can tell when this occurs because the
> - * the Busy Monitor interrupt is enabled together with DMA Mode.
> + * Busy Monitor interrupt is enabled together with DMA Mode.
>   */
>  
>  static irqreturn_t __maybe_unused NCR5380_intr(int irq, void *dev_id)
> 
