Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CA77497A7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 10:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjGFIpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 04:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjGFIpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 04:45:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A602F1BE3;
        Thu,  6 Jul 2023 01:45:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 736C62F4;
        Thu,  6 Jul 2023 01:45:58 -0700 (PDT)
Received: from bogus (unknown [10.57.76.100])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C89CA3F73F;
        Thu,  6 Jul 2023 01:45:14 -0700 (PDT)
Date:   Thu, 6 Jul 2023 09:45:11 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Avram Lubkin <avram@rockhopper.net>
Cc:     robh@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        conor+dt@kernel.org, liviu.dudau@arm.com,
        krzysztof.kozlowski+dt@linaro.org, lpieralisi@kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: Bug introduced in 724ba67 (ARM: dts: Move .dts files to vendor
 sub-directories)
Message-ID: <20230706084511.gp4iuvekkw7lwhdl@bogus>
References: <CAHqEdrPuH4ayMiiq5FixaNjM=r44VJOw-v3iQ0mek55FTUWpsw@mail.gmail.com>
 <CAHqEdrPD_EX=V0RnvvycN1MyXs0e+jkCcQ-nfHwOmyZR2LecfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHqEdrPD_EX=V0RnvvycN1MyXs0e+jkCcQ-nfHwOmyZR2LecfA@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 10:16:19AM -0400, Avram Lubkin wrote:
> Resending in plain text mode
> 
> SImple bug introduced in 724ba6751532055db75992fc6ae21c3e322e94a7.
> 
> The file
>   arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
> was moved to
>   arch/arm/boot/dts/arm/vexpress-v2m-rs1.dtsi
> 
> However,
>   arch/arm64/boot/dts/arm/vexpress-v2m-rs1.dtsi
> is a symlink and still points to the old location
>   ../../../../arm/boot/dts/vexpress-v2m-rs1.dtsi
>

It doesn't break any compilation as it is taken care. I will submit a patch
to remove the symlink soon. Thanks for the report.


-- 
Regards,
Sudeep
