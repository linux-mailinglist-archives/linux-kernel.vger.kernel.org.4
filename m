Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6074B66B6EE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 06:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjAPFol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 00:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjAPFog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 00:44:36 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9315272
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 21:44:35 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30G5iStn002110;
        Sun, 15 Jan 2023 23:44:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1673847868;
        bh=PSubb2WvLeMBpy6M8ueXNkMUIvbv2jd15WidDUEyFsk=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=xuOZcTbw/xMgKDPXv3ocy5MyNYaCLiTKAfMRB8DS7CI+KF4lxJmRO2zFhdjWruQIW
         o2FdPoem+uUL42Kei4ajD6BR8zJ4r8JloYyqFiYIbDg5bG3PhnfOi3Kv0sJVZXgPLj
         mcHhqLHl/24Nfa1gaGUWhNkqtbUX/kH4+b18xHqQ=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30G5iSSu065120
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 15 Jan 2023 23:44:28 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Sun, 15
 Jan 2023 23:44:28 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Sun, 15 Jan 2023 23:44:28 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30G5iQW6026768;
        Sun, 15 Jan 2023 23:44:27 -0600
From:   Dhruva Gole <d-gole@ti.com>
To:     <linux-kernel@vger.kernel.org>, <rdunlap@infradead.org>
Subject: Re: [PATCH] mtd: rawnand: vf610_nfc: use regular comments for functions
Date:   Mon, 16 Jan 2023 11:14:26 +0530
Message-ID: <167384782742.26946.9841853851122100312.b4-ty@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230113064004.24391-1-rdunlap@infradead.org>
References: <20230113064004.24391-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the patch!

Reviewed-by: Dhruva Gole <d-gole@ti.com>
