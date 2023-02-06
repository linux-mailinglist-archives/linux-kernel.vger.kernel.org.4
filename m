Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404A768BAB6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjBFKrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjBFKrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:47:09 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B44A15C8C;
        Mon,  6 Feb 2023 02:47:08 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05CEF13D5;
        Mon,  6 Feb 2023 02:47:51 -0800 (PST)
Received: from bogus (unknown [10.57.12.205])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42A603F8C6;
        Mon,  6 Feb 2023 02:47:07 -0800 (PST)
Date:   Mon, 6 Feb 2023 10:47:04 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: firmware: arm,scmi: Restrict protocol child
 node properties
Message-ID: <20230206104704.xe72srqygepguuk2@bogus>
References: <20230124222023.316089-1-robh@kernel.org>
 <Y9EyB+OO7MyGy20w@e120937-lin>
 <20230125141113.kkbowopusikuogx6@bogus>
 <Y9JLUIioxFPn4BS0@e120937-lin>
 <20230126144647.6q3qlu5sqz27cmyc@bogus>
 <CAL_JsqLxBAB103vgCUOwW4SkAApm6_=Ace7EFWMSDFKDzJaKpQ@mail.gmail.com>
 <20230126170412.4ytcky6a7lnll6it@bogus>
 <CAL_JsqJcrmf2fYVC0TnNY_MZvajJxqXPdVFwLf9MZ2XO=VZ1Lw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJcrmf2fYVC0TnNY_MZvajJxqXPdVFwLf9MZ2XO=VZ1Lw@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, Jan 27, 2023 at 12:52:33PM -0600, Rob Herring wrote:
>
> TBC, 'protocol@.*' would not allow anything but the properties defined
> in the /$defs/protocol-node. So [1] would throw errors without a
> schema addition.

Right I clearly missed that, somehow I assumed it would allow.

> We should either do that along with dropping 'protocol@18' or we keep
> protocol 0x18 node and add all other providerless protocols. I don't
> think we need the latter to just check unit-address vs. reg.

I only argument today it to allow protocol specific transport. So we could
delay addition of it until someone needs that way. So far we haven't seen
anyone using it other than performance(even that is not needed with the
introduction of fast channels that are auto discoverable in relatively
newer versions of the spec).

--
Regards,
Sudeep
