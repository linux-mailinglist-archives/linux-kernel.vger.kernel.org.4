Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCDA724EF9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 23:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239770AbjFFVn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 17:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234403AbjFFVnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 17:43:55 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BDBA7;
        Tue,  6 Jun 2023 14:43:54 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 7EBC75C00FE;
        Tue,  6 Jun 2023 17:43:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 06 Jun 2023 17:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benboeckel.net;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1686087831; x=1686174231; bh=Cj7jNwhxEUWz3YGh46Ym6JKeV
        BhfBtfYbafJNC47oEc=; b=EV6cSfJN/+e3O6NPk2xHDyMT0iYg1wsYBZhxSjecy
        necIJN0wcdKSXBrum8wXN/IV131ScLJdjTJzUcID3c0Vmzf8ed7H6EB+aM8RdoZr
        0H4Rq36LU/FXSjS9pvR5RfT+wEIN/mrwGqdZ66w0BZaNWyPMwFRTLipHexRg3K9F
        qxNfTFqfCutTh8yRGWCQzpei/2pp2DaXle8MKtlYMqpZJjD0ZPDhBuS+D69acFAf
        3Re5bzAzetDHSwmBXREc76FkrVAse5aLlFZ8dP+Kt7b1csZlB1p61RmbyDb8NphK
        m2CbsuwR6nwLI+x0LudylpBCVNIn6vfoTptRVWJc0TorA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1686087831; x=1686174231; bh=Cj7jNwhxEUWz3YGh46Ym6JKeVBhfBtfYbaf
        JNC47oEc=; b=bsCXGcDKILNgxPxyfhGhZOgD2Ku0A24dQgt+FCCKwsjnAmTcPsY
        RpzPykyxZbJzUHfT9KESssrWnaCaL1aiZd5w66Ac+cWl4BZSESnY2W3t43ojopTK
        R4G/+7GWonDsHu2a1dLQwxaa6RjYbZn9A1k2TH15fX571hmjLM3O7ZIQh3ZAsRMz
        7p2pneFyn/7azJ2O9hSP/r/Xa4fzS7SusL8P4hf7mxgR/PMOn6L9f94GBb67VRk4
        sNvoP5yap146P8HTZ1AZnYoAJ3ROTIJsVATcJdhqkrnQRD7uHnsEWvsIAYzaP5GX
        vLQKMBdKMegrYFPS4nKZfdrYTRmwG+PQXTQ==
X-ME-Sender: <xms:l6h_ZB-4reFOSFf3a2L0Jr1oKB0xLuCt8naNMFgYi2LC3HifdZnB6w>
    <xme:l6h_ZFtb7RAkk3d9I8wuXI0_o6OQlC3xo8syjugZDCDPzNeJp4IFUMa4EFBw77OYy
    nwKL11HG9xGSYjqVao>
X-ME-Received: <xmr:l6h_ZPD_Z45mDs7vkq46FfGDnhh2H_np6lOeD_M0bhBIll0I6tNMBkGoPCIH6YGNCGz_vR-NEuVXA4PWQOXA-6NupPrnOM2mJ3IX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtuddgudeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjggfsehtkeertddtreejnecuhfhrohhmpeeu
    vghnuceuohgvtghkvghluceomhgvsegsvghnsghovggtkhgvlhdrnhgvtheqnecuggftrf
    grthhtvghrnhepudekvdejteeuudffveffhfelfefgjeehffefhffhgeeiieduveehfeej
    ffetveefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgvsegsvghnsghovggtkhgvlhdrnhgvth
X-ME-Proxy: <xmx:l6h_ZFcFXWg4DzmX1yFfdukFl9HMQpQlUs-N4jO1Iul-wPgpDTYq5w>
    <xmx:l6h_ZGM035zFSDaoF1VoqiAC3rGBreVDrlGp6acY4ppU1c7R5JKpJw>
    <xmx:l6h_ZHncRPrMU1ywF1JVrgPIZTYLUqDs9X0lMvprq7e5HZJQL2ehvw>
    <xmx:l6h_ZHGlVwAWYNImAeT8mnjoQrrKetjPkHbIteN7YfAO2z-vTA798Q>
Feedback-ID: iffc1478b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jun 2023 17:43:50 -0400 (EDT)
Date:   Tue, 6 Jun 2023 17:43:50 -0400
From:   Ben Boeckel <me@benboeckel.net>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Franziska Naepelt <franziska.naepelt@googlemail.com>,
        keyrings@vger.kernel.org, dhowells@redhat.com, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org,
        Franziska Naepelt <franziska.naepelt@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Linux SPDX Licenses <linux-spdx@vger.kernel.org>,
        Linux Kernel Janitors <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH v2] certs/extract-cert: Fix checkpatch issues
Message-ID: <20230606214350.GA142397@farprobe>
References: <20230601190508.56610-1-franziska.naepelt@gmail.com>
 <20230602085902.59006-1-franziska.naepelt@gmail.com>
 <ZH8mhIrjyBvTF4oZ@debian.me>
 <e39efb7f-5d8f-4433-83b3-8eea8a6c0486@kadam.mountain>
 <CT5NH4XXIYQF.5XXJE6JA5FZP@suppilovahvero>
 <e44d03cf-9993-483c-b3d4-6185f5c028cc@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e44d03cf-9993-483c-b3d4-6185f5c028cc@kadam.mountain>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 18:25:24 +0300, Dan Carpenter wrote:
> I'm looking through the git log to see if it's true the imperative tense
> commit message are shorter and better and neither one of those things is
> obvious to me.
> 
> This patch had an imperative subject already so it was already kind of
> imperative.  Does every sentence have to be imperative or can you just
> add a "Fix it." to the end?

I don't know about the length argument, but it feels like it reads
better when skimming summaries with the imperative mood. The way I think
about it is that the subject should complete the phrase:

    When applied, this patch will…

The body then gives more context and description as necessary. I don't
really worry so much about the mood/tense/whatever in the body except
that I try to use the present tense for anything the patch is doing and
past for any historical context. I understand that kernel maintainers
may care a lot more about it though.

Basically, a patch, on its own, does nothing (just like a recipe). It is
only when it is applied that anything actually happens. I read it as
"`git apply`, please $summary".

--Ben
