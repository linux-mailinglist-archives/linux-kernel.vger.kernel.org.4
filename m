Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7849F74EF20
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjGKMip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbjGKMiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:38:13 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7591A1736;
        Tue, 11 Jul 2023 05:37:53 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BAmxwL018566;
        Tue, 11 Jul 2023 14:36:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=iEhiiDAE5VGpzYoUKMDzsWW+FQbM/7CMQsKlEZM++LU=;
 b=DCavd3BD8Ib/w2kzYs4c7q/cj8Hkq7PqNT4020gfru75qfHko1knOyyxZEvCj7/zjzAt
 6J1fd0CgaQqbPifmabIATh76imkZmt7Q31Qo1BTgatMGwdqwh9SPU2EieSAk/E3VPTtR
 X8O3s4+eYPLC2YnlYAaKjgsO7Sac/c9LlA+wUBDSzAg2um2/Cb4bJHMYdPZGSzRSl7di
 IyRYDuYEcI4QkkwhiEkkT4RuYMQZkOAayuHOJWfIDEM0oEKF8v1OpMOiXJt0O9gtb59f
 SRT8HOLyDWYuBURXScMMluBWe7Ovi1D2G6zYZpiwcepM2gghJqH53ZmUIoMvjF1LKlM1 vw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rs311t6rv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 14:36:14 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 08ED4100058;
        Tue, 11 Jul 2023 14:36:13 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 801DF2248B2;
        Tue, 11 Jul 2023 14:36:12 +0200 (CEST)
Received: from [10.201.21.122] (10.201.21.122) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 11 Jul
 2023 14:36:12 +0200
Message-ID: <6fa4ea12-bc7d-4977-8b7e-bfbea2ef2955@foss.st.com>
Date:   Tue, 11 Jul 2023 14:36:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1] ARM: dts: stm32: prtt1c: Add PoDL PSE regulator nodes
Content-Language: en-US
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>
CC:     <kernel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20230323123242.3763673-1-o.rempel@pengutronix.de>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230323123242.3763673-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.122]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_06,2023-07-11_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleksij

On 3/23/23 13:32, Oleksij Rempel wrote:
> This commit introduces Power over Data Line (PoDL) Power Source
> Equipment (PSE) regulator nodes to the PRTT1C devicetree. The addition
> of these nodes enables support for PoDL in PRTT1C devices, allowing
> power delivery and data transmission over a single twisted pair.
> 
> The new PoDL PSE regulator nodes provide voltage capability information
> of the current board design, which can be used as a hint for system
> administrators when configuring and managing power settings. This
> update enhances the versatility and simplifies the power management of
> PRTT1C devices while ensuring compatibility with connected Powered
> Devices (PDs).
> 
> After applying this patch, the power delivery can be controlled from
> user space with a patched [1] ethtool version using the following commands:
>    ethtool --set-pse t1l2 podl-pse-admin-control enable
> to enable power delivery, and
>    ethtool --show-pse t1l2
> to display the PoDL PSE settings.
> 
> By integrating PoDL PSE support into the PRTT1C devicetree, users can
> benefit from streamlined power and data connections in their
> deployments, improving overall system efficiency and reducing cabling
> complexity.
> 
> [1] https://lore.kernel.org/all/20230317093024.1051999-1-o.rempel@pengutronix.de/
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---

Applied on stm32-next.

cheers
Alex




