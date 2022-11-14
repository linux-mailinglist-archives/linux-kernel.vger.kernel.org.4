Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7019F627457
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 02:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235643AbiKNB5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 20:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235473AbiKNB5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 20:57:17 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65EE625C;
        Sun, 13 Nov 2022 17:57:16 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 1666B5C00EC;
        Sun, 13 Nov 2022 20:57:16 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 13 Nov 2022 20:57:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com.au;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1668391036; x=1668477436; bh=ZCSbXSTClC
        soH9IoKxpSM2OTbMIBunrI93rhd2fC/c4=; b=WB/zmzL+eVUOvIRl02brtzOIEK
        aeg+dayISEXTknxOPN224ob1zfXD8VBpXxoX/1uCE8ijzm2pf/kT+8W+6Ht4MaT9
        ph8BctGIJLVVyQ71bbQXKw+9GqlNTvjmTQA66D5Rd19YEjmYG7JHFRbBp7Z2qZ+M
        pYGBe2TwmfoRnq1LSKgTP/B3V/MVlncGtt6HRwOri38ESpwYA82mwuHqwH4TQTAb
        1MTaimLXk8lXcs4W3sb0GdqDgsJqEkolRGHfJeeRGUhF5Lo4uDgWVcm3AHgTlCwY
        TrHuNK2hMnUmi4zPeJbLDTWUVmc1HSqYyElzZopmrlwAEfkh0SEq7s8qeoNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1668391036; x=1668477436; bh=ZCSbXSTClCsoH9IoKxpSM2OTbMIBunrI93r
        hd2fC/c4=; b=cJT9E3bJJrxRd/yTa1ztNpdF9d4Biop41YHKxXc/qxUE6uY9C4T
        hbfVsg7irpXAAvffJeU/g8fYEPAiZA3QSF/Y7/scQvdnjxF0YaJ+5DAG4cN1NkEJ
        ZpqPAGSFjOH8z5ywLvftzrC0KdpHPfRWg8Ovryr81ddT9hHxCWgpdy6oCU0IqW77
        A5gLNcdfL/huIvYyknCmatdmFCX1pwcQ68m0CpVuyrWncVflEDSWwsdpZeVTzeIc
        gW11fpzexVd/phTtwm63ifRt9JzqEsgTZXeDS18V18tgEAiaAxOVtaQ2tFU1SXdD
        JoGupLjNeWGuGPBg1fgj5QgovgXcGCRTDQg==
X-ME-Sender: <xms:e6BxYxJ1olY5ugVbOzBr2GywqOWBIH205vdRGXvoUdNXa3MIKWErhw>
    <xme:e6BxY9Ig6KiL9ejvBTN54Hu0dn4uJ-VWKLzFrtDFUtPSgfqq1jT3BWVheNbofafO6
    UZAL7sTlDDXmAu3bQ>
X-ME-Received: <xmr:e6BxY5v9Ss0Y54--7VVOvl1ASYVJC88X9HeU6s_9JETYrJEqI4EQgwUK33QuO6mCOlCOxDexco4QOIK3A-wvFROFsaNNluqpWXRakshUCpGnAP28TYZhKDxmOFBdg6Wk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedugdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflohhhnhcuvfhh
    ohhmshhonhcuoehgihhtsehjohhhnhhthhhomhhsohhnrdhfrghsthhmrghilhdrtghomh
    drrghuqeenucggtffrrghtthgvrhhnpeefvdekveeggfekgeehvdelteeiffehgfeihfel
    gfdvkeefvdetkeeuueevleehveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithesjhho
    hhhnthhhohhmshhonhdrfhgrshhtmhgrihhlrdgtohhmrdgruh
X-ME-Proxy: <xmx:e6BxYyapjkIG6BLc4-2Cs9e9iXC-vgOSzfp7WgIZX40U-dj9CyyEjQ>
    <xmx:e6BxY4btAaLOHtSYEByEY12_zyBfpwApJXcSyaqEsA_JS4d7ZOg4Mw>
    <xmx:e6BxY2Aip2LuZGfmglNSyRdee-BR7vHYyneJ2dP4RpOFWmAag0geBw>
    <xmx:fKBxY_XpUnMn8npBItJlJde_ojBm-htUKgwbMWpoE6NnRbxnPKOCIQ>
Feedback-ID: ic081425d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Nov 2022 20:57:13 -0500 (EST)
From:   John Thomson <git@johnthomson.fastmail.com.au>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        John Crispin <john@phrozen.org>,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] mips: ralink: mt7621: fix kzalloc too early
Date:   Mon, 14 Nov 2022 11:56:55 +1000
Message-Id: <20221114015658.2873120-1-git@johnthomson.fastmail.com.au>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ralink mt7621 attempts to use kzalloc before normal memory management is
available.
Before v6.1-rc1, mt7621.c soc_dev_init silently failed to kzalloc and
returned immediately afterwards, continuing to boot without the
SOC_BUS device registered.
After, (with CONFIG_SLUB) kernel crashes before it outputs any console
messages

This was bisected to an mm/slub change (detailed in patch 3)

This change exposed oops in the quirks tables in the mt7621 phy-pci &
pci-controller drivers. The phy-pci quirk fix got into -rc5,
but the pci-controller quirk fix has not been picked up yet.
https://lore.kernel.org/lkml/20221114012036.2870067-1-git@johnthomson.fastmail.com.au/T/#u
This is mentioned in patch 3 as:
not yet applied ("PCI: mt7621: add sentinel to quirks table")

Changes from RFC
https://lore.kernel.org/lkml/20221103050538.1930758-1-git@johnthomson.fastmail.com.au/T/#u
to v1:

1/3:
cut the CPHYSADDR to match the line moved to the header file
2/3:
No useless const unsigned {int,bool} function declarations (thanks
kernel test robot)
3/3:
static struct *soc_info_ptr
Mention fixed phy-pci & (unapplied) pci-controller quirks sentinels
Add fixes tag

Cheers,
John


