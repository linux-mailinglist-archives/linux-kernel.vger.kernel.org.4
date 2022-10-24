Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC96F609B54
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 09:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiJXHbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 03:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJXHbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 03:31:31 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DED4CA2E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 00:31:12 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id B175D32007F0;
        Mon, 24 Oct 2022 03:31:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 24 Oct 2022 03:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1666596670; x=
        1666683070; bh=OwF0mv2AJHzrKoKJS1vLjaS10D0Sn6RA5rvBvSUlk3E=; b=z
        DcEKTXs086tYnYJ+RvH38kQMLSdHewwI1epb7MxHj/11/ws3pXLbbyyBBK4Pvfvl
        oRneo/u9irBMzzyUlC+CEDve7I6yg4gOvc9hWDSAYKL8RaC+/XYPXwZm5kzvY1GM
        w+4Cuxq/7owMQlJwWWvoeOXr0YvBkSocHki34jyM2ZlXTfAOzMy0G9XvBvkYjJOy
        CJId0gX+AklxtQIlyIvFKZ5JL72aM3jVB2qVgMZN7uj/r9ZAL20qQtItpi2D8OyI
        VYH8btBD19XMz2h4Au98M8Vb54wTbZQpAtgWzBrVvqmpOyH3twLPxHlP/T7DJLD5
        RvNBM99/CUbEdNn/MlowA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1666596670; x=
        1666683070; bh=OwF0mv2AJHzrKoKJS1vLjaS10D0Sn6RA5rvBvSUlk3E=; b=s
        8gN7zioIGP7+tpwRouZU0TcgC1h2PWBHdNswUaXYJF6VuNeUZYAe//UPWabPrD92
        fuKHGsjLvDUgBe2MqNtt0C44dPHoUyvBCrSO1cdUaG72WvDw8M8ULOE/wD7h2ynx
        t0K4gqQ5u/0Rg3sH/cF9gdpahGD7HWxwZ+4vhmyNxzyirVRTxwyUyQhjEGn9UDvi
        8DL1phJ1w+gOX/f96deKP675lWgUPhhHeR+h2phxMeWvWbugjAkR1rXuIMYv3dFN
        TCdX8y3pTIZojaRgtObpQxGu5fOFV6w010+Nv47TJeTJAjnKhPxrnNkJZ+9sNcwn
        SsKSEIWZBUADQ4fGSedXA==
X-ME-Sender: <xms:PT9WY6aR24B5IH8-NJRLnV2SLDrrl9xCbCBW-He9guHi0ervp7YMIA>
    <xme:PT9WY9ZDVqODl1qz0QXtWipM8D9NdqRvFo_GR8Jd3b1-m15gkRDw3nAMFa2cIP0t1
    7nUgiYxdK71RXpnnEQ>
X-ME-Received: <xmr:PT9WY09-VSELldVgnbrmUhusqJz5X-WyN7Jgn6ClJLALCsSwPPFDufDByKViCXN81iBvxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgedtfedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvegjfhfukfffgggtgffose
    htkeertdertdejnecuhfhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghhnecuggft
    rfgrthhtvghrnhepteefheefgfeujeduhfeugeffleetueeuvdfhlefhfeejteejhfdtff
    dtgfdvjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:PT9WY8otmThm3F_QGhx_4FFUZCnNGONKjuaORlyRZKvwS7FHncSUDQ>
    <xmx:PT9WY1q_11ZCMEZhWi2oEx3fWesbAIMC4d0hT2cjRngGmVEFemSAtA>
    <xmx:PT9WY6TxpcOBLU_tDxFfKzCnXnNbq17i5fwMU4ne9wNHaMuY21YDbw>
    <xmx:Pj9WYwAaiH-pTf-mFXxuri60ZwIqcWc-mWlGK4Mm4z8hJ0puJsotMg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Oct 2022 03:31:08 -0400 (EDT)
From:   maxime@cerno.tech
To:     airlied@linux.ie, maarten.lankhorst@linux.intel.com,
        tzimmermann@suse.de, wangjianli <wangjianli@cdjrlc.com>,
        daniel@ffwll.ch, mripard@kernel.org
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20221022060701.58280-1-wangjianli@cdjrlc.com>
References: <20221022060701.58280-1-wangjianli@cdjrlc.com>
Subject: Re: (subset) [PATCH] gpu/drm: fix repeated words in comments
Message-Id: <166659663443.12501.5477862749061418647.b4-ty@cerno.tech>
Date:   Mon, 24 Oct 2022 09:30:34 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Oct 2022 14:07:01 +0800, wangjianli wrote:
> Delete the redundant word 'the'.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime
