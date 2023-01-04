Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C7F65CF9A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 10:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbjADJew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 04:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239051AbjADJeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 04:34:25 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF5065F7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 01:34:24 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 562095C0160;
        Wed,  4 Jan 2023 04:34:22 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute5.internal (MEProxy); Wed, 04 Jan 2023 04:34:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1672824862; x=1672911262; bh=f+
        jnYbjKkcGa4orSRr51wlvhbjDUTHP0WzFeB65hkKI=; b=XG5NsyuO5oIi9m1QsA
        aY1Tifw8aYg4xPf4tW/3vDfkF8crVHQWlU3GMese8JGmxh4btldiJkF8zCpO4+45
        wKv3Kim21Jf626pw253t1bE8b97E8g2wkaAWl69LaciDDgifoiGRgD/XNVQrFVLb
        hpUXVt2Gn9dU2lWBqK24a7+Z3fiy3LcPAWDAvfMQ148SZHBJHUkkXZ7RMmWp9f4U
        kQFy/+9VIoe7UUFEiwuxSg2RkNE25A5JbE8a8w417pZzQ0wR7cKUUjnrO6z/ZO2i
        4o4Qo9dALfqOMfYOIsTjbCRZimHjkiZe4Kjzm5ev1B2CAsT8PmPlQ0/xEGQPxZEG
        Sfug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1672824862; x=1672911262; bh=f+jnYbjKkcGa4orSRr51wlvhbjDU
        THP0WzFeB65hkKI=; b=X9HDDIpQ6rdXzpKDkUqkDg4BwR//zGRYNT97c6euphFs
        eg1IA6ZNfrKHAph5rEnoQ83b8G5bjQqe2q87R2SYAK09D5BXMgb6v7eBU+pbzF4K
        w01CuktLPTkTjOFtbz2hkpYR2iRPcpKRSsekQDo74iu3Ap+/DqPpXK/TcFFPekyk
        g5bGbKQAuayq+lequ8QAaWyUV3xgoVUz7JEiruLWZixeAqJY07J3B6czpkLzTa3I
        O/XUi1PMnQxZLBzxfDDzYXey5ENO7pqO15tyh5XhgJtAwf6w8wxbK2eF94tQ0/lr
        A/l4SiBS2xmFKTM2E4gXBlaK3epfMAjzRlh10tbKAA==
X-ME-Sender: <xms:HUi1Y4XhYXXBcbBDl9iCGnVqmEdVGBv9EYfCGodu_OcnKdYHMtbP6Q>
    <xme:HUi1Y8mf3G_teSr0zZvmsefl-rrPmm6tpop0DiSspSiyOVtjP2A6IWxBH0HdMxYbq
    Wv7u0CzOHhwvyeCSX8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeeigddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpeelvefggeffheevtdeivefhkeehfeettdejteduveeiheevveeilefghfei
    veeiueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:HUi1Y8b2KmsTy8rJZLYL2jOoxLSnBIyqE2Zhg0Lbu5f8Srk_093IAQ>
    <xmx:HUi1Y3VibLJXKJadKqOx8iRkDaQRpyrRecjazKFuJZOH7JH9rzZo9g>
    <xmx:HUi1YynOus5-FknWgCrKDQ1N5m6-5UsXDtNePGAIqLlmtGMeJyAmEg>
    <xmx:Hki1Y84cPdVHRbVURSxp-KFAjuwaEUWj7q8sM8q4m6IYcqQrTjerWQ>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C501AA6007C; Wed,  4 Jan 2023 04:34:21 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <548661c9-165c-495b-b12a-ab25e92ece63@app.fastmail.com>
In-Reply-To: <20230104092148.15578-1-marcan@marcan.st>
References: <20230104092148.15578-1-marcan@marcan.st>
Date:   Wed, 04 Jan 2023 10:33:56 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Hector Martin" <marcan@marcan.st>,
        "Keith Busch" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Cc:     "Uday Shankar" <ushankar@purestorage.com>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-apple: Add NVME_QUIRK_IDENTIFY_CNS quirk to fix regression
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

Hi,


On Wed, Jan 4, 2023, at 10:21, Hector Martin wrote:
> From the get-go, this driver and the ANS syslog have been complaining
> about namespace identification. In 6.2-rc1, commit 811f4de0344d ("nvme:
> avoid fallback to sequential scan due to transient issues") regressed
> the driver by no longer allowing fallback to sequential namespace scans,
> leaving us with no namespaces.
>
> It turns out that the real problem is that this controller claiming
> NVMe 1.1 compat is treating the CNS field as a binary field, as in NVMe
> 1.0. This already has a quirk, NVME_QUIRK_IDENTIFY_CNS, so set it for
> the controller to fix all this nonsense (including other errors
> triggered by other CNS commands).
>
> Fixes: 811f4de0344d ("nvme: avoid fallback to sequential scan due to 
> transient issues")
> Fixes: 5bd2927aceba ("nvme-apple: Add initial Apple SoC NVMe driver")
> Signed-off-by: Hector Martin <marcan@marcan.st>

Nice, I've been meaning to look into those weird namespace scanning errors
for a while now but never got around to it because they didn't break anything.

There's a chance this is also required for the later T2/x86 Macs in pci.c
(PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2005)) since they share a similar firmware but
I don't have access to those to test if this is actually required.

Reviewed-by: Sven Peter <sven@svenpeter.dev>



Best,

Sven
