Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DBD65F290
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 18:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbjAERX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 12:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235459AbjAERX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 12:23:26 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CB060864;
        Thu,  5 Jan 2023 09:17:17 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 822035C00E8;
        Thu,  5 Jan 2023 12:17:14 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 05 Jan 2023 12:17:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1672939034; x=1673025434; bh=YO6faB5Bnc
        E5+o9ZEze4iSt5FwH9o/YwMK8imz2KE08=; b=fZP+dW+4WObZGoJPqe5kEtiu3Y
        Ay1nwf9QDU8xxrUETlCwRhh6cBJ8RGEKAmalgGlQb3unmcgUUjqG5TvSCEZTW57F
        I6QtJzHNBfpqgjAUIDsywlUtWTlcntleSuBnok+G12rgaid1A0/rqNS8MuyIsW+6
        Fj64hbaklZ3slXk9mSbfU3Zi9/IwayP6lJ3e8/ZIv2OXczZk73TYJm5SLH3EEA2Y
        1UjagnHBnPf1uw63E3zHEzqKXByx6HEWM0T1U/C3HKYY/7jRTfpNSQwpmhHlxw/6
        cA6q+WAFrAWvG1yqTX/Tvc5300qelSQpWlLTUp698KAtNpi7AbWClhYSFhPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1672939034; x=1673025434; bh=YO6faB5BncE5+o9ZEze4iSt5FwH9
        o/YwMK8imz2KE08=; b=w3k4sf4/qBpNYPJijS8DUc2N60PVdXMXCdJSI0U3Lcbl
        gj4r/wOl68oMSR7JPDnatPOO0xHKZnTbA3WQAqA0aE6ucRdrsahsXiU4A1LrhdM2
        gkI4uHGl0bSEFFk1Nnl4vL+OdPMqZ45wpmiZQBdEV9yxu+OL3SIs31bF+VIhIS/+
        oV2DloenSq+PdYLCIgPJ+eQcWvp4D20adye0GPh6DGw0WwnEHi6wPGpo5kCaNbJs
        9rHPhCXSOdrAr0vSm9uCCSyYXI45eNe+Q+v4ZMxmTrlZLBNWL2sa/eyfEIxDNFTx
        PdkkqerH33/BLLiP+1PAg14E8jsAbmxei+JKy9SqwA==
X-ME-Sender: <xms:GQa3Y5J8OphEER6ihrNPdQqY8n4EqtjnP5m6IaQSs4bUQ9Y8D--4IA>
    <xme:GQa3Y1JSYBekF4z5q3k9ywPBY8HCvitdpXcuEraXwVfKTN3JB24wiIvNFvKJ3J1QI
    wa4XedEBLhQZeaRjVs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeekgddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:GQa3YxsR8XQYSiNuS3a3d2bzNx5nMbMXMtEZBwWVCHOFltmFxWPKsw>
    <xmx:GQa3Y6b2ydO97iDxaMM9NpQpw9GVCHwGkhNE3qn0EmRpMmppCsYlRw>
    <xmx:GQa3Ywbt4jGz_xOuCZ6zb_96IAbGjoI3zxMeAfqkaUxi2GWX-wtidw>
    <xmx:Gga3Y_yG9t-uLISckc0ihmTs4HO7a1xDz6S_w_GK6P_5Hg6vdNO_cw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D8CC0B60086; Thu,  5 Jan 2023 12:17:13 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <26b6968a-163d-4afb-beb9-dbec940080af@app.fastmail.com>
In-Reply-To: <20230105164247.ss7yckr54ce6xg6n@mercury.elektranox.org>
References: <20230105134622.254560-1-arnd@kernel.org>
 <20230105134622.254560-8-arnd@kernel.org>
 <20230105164247.ss7yckr54ce6xg6n@mercury.elektranox.org>
Date:   Thu, 05 Jan 2023 18:16:53 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Sebastian Reichel" <sebastian.reichel@collabora.com>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Robert Jarzmik" <robert.jarzmik@free.fr>,
        "Daniel Mack" <daniel@zonque.org>,
        "Haojian Zhuang" <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 07/27] power: remove tosa_battery driver
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 5, 2023, at 17:42, Sebastian Reichel wrote:
> Hi,
>
> On Thu, Jan 05, 2023 at 02:46:02PM +0100, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> The PXA tosa machine is removed, so this driver is no longer
>> in use.
>> 
>> Cc: Sebastian Reichel <sre@kernel.org>
>> Cc: linux-pm@vger.kernel.org
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>
> I suppose I could queue this directly, but feel free to just
> take it with the other two power-supply driver removal patches:
>
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Thanks! Yes, I'll just keep it all together.

   Arnd
