Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E466B091A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjCHNbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjCHNb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:31:29 -0500
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E74907B0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 05:29:38 -0800 (PST)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PWtT62FDnzMrdNx;
        Wed,  8 Mar 2023 14:29:30 +0100 (CET)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4PWtT54s6HzMsSrD;
        Wed,  8 Mar 2023 14:29:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1678282170;
        bh=U2d/hn5XlwuPMVp567Af6uB83HuCxKsjuK0ZR5RJJvs=;
        h=Subject:From:Reply-To:To:Cc:Date:In-Reply-To:References:From;
        b=zT+5NG7+4z7CSxyCCDX7xvBKeSwjGnvMuR2VgOBii6AQYqVUICnZDNpSnVKeIUU5e
         u1BcM+2N6xiiMlvsf0RJKm+Kzw5jhckinE2YO4NuQ9aY6rk5zPbsn5IvvaRzPPmDnr
         6gqU1agKt+zLUGMXTxxWTTaJdXqFtFBng3sO4aGc=
Message-ID: <309ec2042a73b943485671f926ec0f25c5d8f80a.camel@pschenker.ch>
Subject: Re: [PATCH v1 03/25] arm64: dts: colibri-imx8x: Sort properties
From:   Philippe Schenker <dev@pschenker.ch>
Reply-To: dev@pschenker.ch
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 08 Mar 2023 14:29:29 +0100
In-Reply-To: <9d213504-d457-21a6-d467-41d8783d53d3@linaro.org>
References: <20230308125300.58244-1-dev@pschenker.ch>
         <20230308125300.58244-4-dev@pschenker.ch>
         <9d213504-d457-21a6-d467-41d8783d53d3@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-03-08 at 13:57 +0100, Krzysztof Kozlowski wrote:
> Is this approved coding style for IMX DTS?

How the ordering should be done is nowhere specifically documented (at
least this is my current understanding).
The ordering how I noted it is what we gathered from multiple feedback
on mailinglist discussions.

With that ordering I hope everyone is happy.

Philippe

