Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E6867B2B0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 13:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbjAYMm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 07:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjAYMmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 07:42:25 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 816904C24;
        Wed, 25 Jan 2023 04:42:23 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAF5C4B3;
        Wed, 25 Jan 2023 04:43:04 -0800 (PST)
Received: from bogus (unknown [10.57.77.84])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85DAD3F71E;
        Wed, 25 Jan 2023 04:42:21 -0800 (PST)
Date:   Wed, 25 Jan 2023 12:42:18 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: firmware: arm,scmi: Restrict protocol child
 node properties
Message-ID: <20230125124218.kp4icrzjqkzqrzir@bogus>
References: <20230124222023.316089-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124222023.316089-1-robh@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 04:20:23PM -0600, Rob Herring wrote:
> The SCMI protocol child nodes are missing any constraints on unknown
> properties. Specifically, either 'unevaluatedProperties' or
> 'additionalProperties' is needed. The current structure with a regex
> match for all child nodes doesn't work for this purpose, so let's move
> the common properties '$defs' entry which each specific protocol node
> can reference and set 'unevaluatedProperties: false'.
>

Makes sense to me. Also thanks for $defs example, wasn't aware of how
to do that.

Can you please take it though your tree ? Assuming that,

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
