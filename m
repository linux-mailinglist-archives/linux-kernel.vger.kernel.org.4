Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C266166DCA5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 12:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236807AbjAQLhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 06:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236100AbjAQLgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:36:53 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B26360B7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 03:36:26 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30HBaPDF022621
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 05:36:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1673955385;
        bh=tDYv0Kb7rdM6tTmDAMkqZBwdZHEbXQU+Nd5ouYuNrjU=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=bp5iqPtIS3cfI6jWxJZX8MUo9UHP+mA/8XIS3SIf7HqcGIrZ669SSVyuXMBTv98Zd
         iV0UqLJDben72MNW06+mQGr2ukp8yHQwvlczlE8bzm/pAuSNQbN1kgBKN1mX7pCa7+
         P81VrvlyGF5SO2MRLiOgtO7sP7nhVegu2yt94dNQ=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30HBaPAH071884
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 05:36:25 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 17
 Jan 2023 05:36:25 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 17 Jan 2023 05:36:25 -0600
Received: from [172.24.223.167] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30HBaNef115444;
        Tue, 17 Jan 2023 05:36:24 -0600
Message-ID: <c81c6f07-baac-9b86-24c1-4611e836d26f@ti.com>
Date:   Tue, 17 Jan 2023 17:06:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Test
To:     Achal Verma <a-verma1@ti.com>, <linux-kernel@vger.kernel.org>
References: <20230117100140.GA3278026@desktop-3598>
Content-Language: en-US
From:   "Verma, Achal" <a-verma1@ti.com>
In-Reply-To: <20230117100140.GA3278026@desktop-3598>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Testing as my previous reply not saved in archive.

On 1/17/2023 3:31 PM, Achal Verma wrote:
> Test-email
> 
