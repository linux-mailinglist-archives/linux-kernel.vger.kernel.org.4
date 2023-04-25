Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC766EDA7F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 05:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjDYDIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 23:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbjDYDIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 23:08:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0A4AD32;
        Mon, 24 Apr 2023 20:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=AD+WFqnr7WOdrfSSyEl2rF/OdljOscWhoPEezj0bUv0=; b=joLfqcnqssIPIDpyLil0zqosUK
        6mulgUBMZOH30QotgPAtS6mclR37z4nxKbbGaTbBeeNNQZOtxAoJs2Z8gZwV7/RSC7rVPAEanM3nw
        pOEnAEZqWDlOg3uHU+WKJWz1cg6uJic45Mnu2OBs0FptpmRCqZLPonB9jWtviwQmQjfIxJAe3Kg14
        upw8UkL88630q+qT2b2bOlSxoHVgtiuOsu9DdpIRBn1/AHyTWnLeppARydEJhbqLTLDyOxFGSuHZL
        uR+vWSG4jzfRER76FOkkT3w4OMBZHcrof6bn2xdgj2oEcKuFOvSbdBybH4CJhripnHbmFfCAovxbH
        N67PL/AQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pr92K-0004kc-0s;
        Tue, 25 Apr 2023 03:08:12 +0000
Message-ID: <c56349d2-594a-bba0-3e88-40125fca3589@infradead.org>
Date:   Mon, 24 Apr 2023 20:08:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/4] platform/x86: wmi: Mark GUID-based WMI interface
 as deprecated
Content-Language: en-US
To:     Armin Wolf <W_Armin@gmx.de>, hdegoede@redhat.com,
        markgross@kernel.org
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230424222939.208137-1-W_Armin@gmx.de>
 <20230424222939.208137-3-W_Armin@gmx.de>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230424222939.208137-3-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/24/23 15:29, Armin Wolf wrote:
> The WMI driver core supports a more mordern bus-based interface for
> interacting with WMI devices. The older GUID-based interface depends
> on each WMI GUID and notification id being unique on a given system,
> which turned out is not the case.
> Mark the older interface as deprecated since new WMI drivers should
> use the bus-based interface to avoid this issues.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/platform/x86/wmi.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>

thanks.
-- 
~Randy
