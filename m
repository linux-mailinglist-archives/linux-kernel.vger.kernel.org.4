Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5A96E6D73
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 22:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjDRUZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 16:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjDRUZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 16:25:45 -0400
Received: from st43p00im-zteg10071901.me.com (st43p00im-zteg10071901.me.com [17.58.63.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CF36A4E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 13:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1681849539; bh=5yMNkG+u5q3+ofdusgRob/P+SEqiawyHY5sUYJmY4o4=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=XZe7YIkOYZcOwvr6pRDkBxsvTuFzax8UD98w+Ci2Hdk7U/8li+Sw+8HutS8lYeMz2
         xMcNiTsPieyj1BaGYUH7/5ud0a/+OFdBe6uq7lha7xYaQNS4lx00/4NIeBPt8OEQSu
         LGduVjGBPYWQ6VosKwXEiX6jBA5IB86a2ZbGgLT59OWWSD+ApUOtc2w5QSeCsQ+zpy
         rUATLH3x/ak3NCclXyTFIqZv20mGm8APl8tuW/0jzLcuTuW2vZ0FN1WCpctQgRveMb
         kLX4rDlYcJYt9hosiyx4zaYl2Yi2ayAjk7Tear3/xchocxFVt/xYhgApzFEvzPWaxD
         wz0L0BcuYYtxg==
Received: from imac101 (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
        by st43p00im-zteg10071901.me.com (Postfix) with ESMTPSA id E8043840C1E;
        Tue, 18 Apr 2023 20:25:38 +0000 (UTC)
Date:   Tue, 18 Apr 2023 22:25:35 +0200
From:   Alain Volmat <avolmat@me.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Subject: Re: [PATCH v3 0/2] dt-bindings: sti: updates for STi platform
Message-ID: <ZD78vycteFErVHsj@imac101>
Mail-Followup-To: Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
References: <20230213185633.15187-1-avolmat@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213185633.15187-1-avolmat@me.com>
X-Proofpoint-ORIG-GUID: v16IIltn34eO3REYHMg0rBi3Lk2rvs4Y
X-Proofpoint-GUID: v16IIltn34eO3REYHMg0rBi3Lk2rvs4Y
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.816,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-17=5F04:2020-02-14=5F02,2022-01-17=5F04,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=671 clxscore=1015
 spamscore=0 malwarescore=0 adultscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2304180169
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

gentle reminder, could you consider this serie of dt-bindings updates
for the STi platform.

Alain

On Mon, Feb 13, 2023 at 07:56:29PM +0100, Alain Volmat wrote:
> Update the sti.yaml file with addition of board information and
> removal of no more supported STiH415/STiH416
> Add the st,sti-syscon.yaml binding file for STi platform syscon
> 
> Alain Volmat (2):
>   dt-bindings: soc: sti: add STi platform syscon
>   dt-bindings: arm: sti: add STi boards and remove stih415/stih416
> 
>  .../devicetree/bindings/arm/sti.yaml          | 25 ++++++----
>  .../bindings/soc/sti/st,sti-syscon.yaml       | 46 +++++++++++++++++++
>  2 files changed, 62 insertions(+), 9 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/soc/sti/st,sti-syscon.yaml
> 
> -- 
> 2.34.1
> 
