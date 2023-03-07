Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC15A6AD8F7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 09:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjCGIQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 03:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjCGIQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:16:25 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843A350997;
        Tue,  7 Mar 2023 00:16:11 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id F03A65C013F;
        Tue,  7 Mar 2023 03:16:10 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 07 Mar 2023 03:16:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1678176970; x=1678263370; bh=8C
        6VRDlcxQhH+mSpw+nDDgGpxEIKQm9RL18lCT50WgQ=; b=N8RZhZsHo49RtxHhXw
        eIIUbw2NFCNlTZbpZ9Tb9n7m9U8jpOkbuQyD8MDvJynsAzzGqWWvr8U3Ydt3VF7m
        0oQTKWO3wF+3/vs85ZLKWq5ofm9fntOwAfcrzN00x5QGyleNeQs12kfOESuY1G5u
        nqKKrtRTCZv3Ot3zNRRjzlv6ft/YlWQhIllf+pe32fvkbib65DqdoipTxi4WXLZJ
        qBGCl5vO3imvGX/0m/sibUq2O4Sac/yrV+0FMEfxuX8jLxdaolFK7Jg+0Eco/76t
        E9EhGpAaWxeOq05tLIaP/eDl1UkBZ601+fU32NEMOxr13mwkgqGGL346hAMZ7lHL
        hb8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1678176970; x=1678263370; bh=8C6VRDlcxQhH+
        mSpw+nDDgGpxEIKQm9RL18lCT50WgQ=; b=oYBKZNa2k+kbf6GRcK2SQFkYf55sJ
        hF//TPcdDfl81FggoAOg/Ado4CtID9mymJDqhFAVOhUnUvTqxPpu4nY33IpLzbd0
        dasK94wHOAXu/NVgW2qJJ63tqawoxXvg0Vr0+AdgxlAtxY0OgfwVSnJaCKF8R3P+
        V90rZbuQMzX15HfoIthX/O16jRx8wg6A+RVFtkdEtX0yoe62OfhGOM8bTuv+GkOz
        N5Zf5Im4Vf4JeGSZ8x3vp+5yWxJJRHAiK0yf079J/E/16e3O47q/mBdptLp3wyrV
        7m205vQgLtXv1Lf35YnClj2GcO8KpMMnMD+tUYA+Ae/igN9AEjonuG8XA==
X-ME-Sender: <xms:yvIGZM0Yybb5PhVUQ3udu_2OKChQFsPHEnKjXth8E4c_lrg_RJE9-g>
    <xme:yvIGZHHZ2WqH9A7L0MfSpRhvSes4_T94uSrx_J09K3yPhPMrmysbo5cRZK8Pcnx2a
    RSd_MWEpAbMuDCswMk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddtledgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:yvIGZE5zqaF0cM3HRyIFRF5zCBj5snQdOENGGLlv9V0KcJVV17daUQ>
    <xmx:yvIGZF2YiUepTP5aTlW837uM0rB2EJ538_m72vALVev3SO9gcfQFLg>
    <xmx:yvIGZPExeWxW_d1SGJ0LHKlKSKc2JQX8WI0BUPR6mFn19i8R1xcMVg>
    <xmx:yvIGZDjhMMAVNutvq8vUxcH6VRw61DzMNZ2jp5VDXLSgi-Jcs2SZhQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 73950B60086; Tue,  7 Mar 2023 03:16:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-206-g57c8fdedf8-fm-20230227.001-g57c8fded
Mime-Version: 1.0
Message-Id: <61c230da-a826-4cbf-8e4c-79e607ce5878@app.fastmail.com>
In-Reply-To: <20230307074038.17391-1-lukas.bulwahn@gmail.com>
References: <20230307074038.17391-1-lukas.bulwahn@gmail.com>
Date:   Tue, 07 Mar 2023 09:15:49 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Lukas Bulwahn" <lukas.bulwahn@gmail.com>,
        "Miquel Raynal" <miquel.raynal@bootlin.com>,
        "Richard Weinberger" <richard@nod.at>,
        "Vignesh Raghavendra" <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: parsers: remove reference to config MTD_NAND_TMIO
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023, at 08:40, Lukas Bulwahn wrote:
> Commit 568494db6809 ("mtd: remove tmio_nand driver") removes the config
> MTD_NAND_TMIO and its corresponding driver.
>
> Remove the reference in MTD_SHARPSL_PARTS to that removed config.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Arnd, please ack.
> Miquel, please pick this minor non-urgent patch on top of the commit above.

Acked-by: Arnd Bergmann <arnd@arndb.de>
