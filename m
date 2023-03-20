Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E4E6C0D71
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjCTJgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjCTJf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:35:56 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977652413A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 02:35:33 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32K7F5K9024145;
        Mon, 20 Mar 2023 04:35:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=PODMain02222019;
 bh=iSaww0mrqhKwTlaGqHNwuY7eqsGxVnwAwh8sP3T5lqA=;
 b=pymYL24zh3LUP8oVda1OKRu07nK757dVAxdDk2sbi3CbkdsREk0U1S6NYf5rzXhncV33
 okihQu02XaUBx58r3HqMJPSgNBzJOWUJCuKxA4IPEI0n9UzGSKdAotjcc0tY8xk+4Etp
 nQNRK+48JXOkk7PFjdQx1Jdi/sGmHg9vakJslP9+QgyM69tBKKfvXYp+EvXjDeUyZTDf
 YTihGW7ekvbiupt60BgQDlMmv/A6SsiXaDIGq1SKwOqhaTCliy1PSnkw33w1zQI5uSJE
 dF5/5Z1Jy6Dq0jjPqd3Zilj1GE4fFlLjHJZ2QIGIEXuM7omhGP4ivgLWYexcT+eMBKVV gQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3pd9qpt8u3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 04:35:21 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Mon, 20 Mar
 2023 04:35:18 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 20 Mar 2023 04:35:18 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2CDFA11D4;
        Mon, 20 Mar 2023 09:35:18 +0000 (UTC)
Date:   Mon, 20 Mar 2023 09:35:18 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     =?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>
CC:     Lee Jones <lee@kernel.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>
Subject: Re: [PATCH] mfd: arizona-i2c: add the missing device table IDs for of
Message-ID: <20230320093518.GJ68926@ediswmail.ad.cirrus.com>
References: <20230319124153.35294-1-git@apitzsch.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230319124153.35294-1-git@apitzsch.eu>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: hm8ytVwUae6Ecn56T0Yq9u_FZX9HP4Gh
X-Proofpoint-ORIG-GUID: hm8ytVwUae6Ecn56T0Yq9u_FZX9HP4Gh
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2023 at 01:41:53PM +0100, André Apitzsch wrote:
> This patch adds missing MODULE_DEVICE_TABLE definition
> which generates correct modalias for automatic loading
> of this driver when it is built as a module.
> 
> Signed-off-by: André Apitzsch <git@apitzsch.eu>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
