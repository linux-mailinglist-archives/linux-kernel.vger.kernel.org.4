Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41BF5F30AB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 15:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiJCNE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 09:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJCNEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 09:04:55 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9221C118;
        Mon,  3 Oct 2022 06:04:50 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2938p6Za026051;
        Mon, 3 Oct 2022 15:04:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=date : from : to :
 cc : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=selector1;
 bh=n2dod6jOO9mn4/av9Xj9sPyCVY0WZR1VS0HeSNd5cvc=;
 b=VzYkUzBClM6TJ5XnlWb3vQVm9B1+kS6SeKoDnOCx8Y2+QDEixG+9Kyh4TLp1+Xb7RKCB
 98bpLrdHSZwNcGch8cQOgSnWRGsY0a6+XnsI57jN12mnCaBcUyupiy8++tyUC6tEwR0i
 pGGj/DBTj6ivljsVB3XRNEati5gKcvnuvmAO2a411sZWLv/ZvbFu+DPRezboOhT8MAzr
 luiqTwP7Uaxz/4TY1zMyU0iziEj9qRXAGrhtGAgj0FKlL4zqXd9ZtYVpc+sqqipo2qpZ
 dtarAHGoA+CeO3Yi8nBmDfZRKJhyWi7rCWp9Pjo+fEyF7LALKzkHgBLn7IQ95VJMWl8a 4Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3jxcehtc68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Oct 2022 15:04:27 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3C2FF10002A;
        Mon,  3 Oct 2022 15:04:20 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F13B722A6E8;
        Mon,  3 Oct 2022 15:04:19 +0200 (CEST)
Received: from gnbcxd0088.gnb.st.com (10.75.127.118) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Mon, 3 Oct
 2022 15:04:17 +0200
Date:   Mon, 3 Oct 2022 15:03:55 +0200
From:   Nicolas Toromanoff <nicolas.toromanoff@foss.st.com>
X-X-Sender: toromano@gnbcxd0088.gnb.st.com
To:     Colin Ian King <colin.i.king@gmail.com>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Nicolas Toromanoff <nicolas.toromanoff@foss.st.com>,
        <linux-crypto@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: stm32 - Fix spelling mistake "wite" -> "write"
In-Reply-To: <20220928222443.68705-1-colin.i.king@gmail.com>
Message-ID: <alpine.DEB.2.21.2210031455360.10257@gnbcxd0088.gnb.st.com>
References: <20220928222443.68705-1-colin.i.king@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"; format=flowed
X-Originating-IP: [10.75.127.118]
X-ClientProxiedBy: GPXDAG2NODE4.st.com (10.75.127.68) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-03_02,2022-09-29_03,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2022, Colin Ian King wrote:

> There are a couple of spelling mistakes in dev_err messages. Fix them.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Hello Colin,

Thanks for the patch.

Acked-by: nicolas.toromanoff@foss.st.com

-- 
Nicolas.
