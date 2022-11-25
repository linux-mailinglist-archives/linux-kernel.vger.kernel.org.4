Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F2E638690
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 10:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiKYJr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 04:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiKYJqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:46:54 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A90DF42F55
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 01:45:45 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1AD423A;
        Fri, 25 Nov 2022 01:45:51 -0800 (PST)
Received: from bogus (unknown [10.57.6.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 256A53F73B;
        Fri, 25 Nov 2022 01:45:44 -0800 (PST)
Date:   Fri, 25 Nov 2022 09:45:41 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Wang Honghui <honghui.wang@ucas.com.cn>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk-scpi: Modify to recall scpi_clocks_probe
Message-ID: <20221125094541.6ycyef7nl7motaii@bogus>
References: <950BEC68ABB5129B+Y4Ap/WUNrJ2BTmYD@TP-P15V.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <950BEC68ABB5129B+Y4Ap/WUNrJ2BTmYD@TP-P15V.lan>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 10:35:41AM +0800, Wang Honghui wrote:
> Modify to recall scpi_clocks_probe
> and add to support Phytium FT2000/4 CPUs
>


*NACK*

Please stop this getting SCPI and custom mailbox in ACPI madness.
You seem to have missed reading all the information provided on PCC
and PCC OpRegion to get these working in ACPI.

-- 
Regards,
Sudeep
