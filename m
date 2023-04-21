Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9FD6EA78F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 11:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbjDUJtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 05:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbjDUJs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:48:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5820C159
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 02:48:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E326150C;
        Fri, 21 Apr 2023 02:48:51 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F55A3F5A1;
        Fri, 21 Apr 2023 02:48:06 -0700 (PDT)
Date:   Fri, 21 Apr 2023 10:48:04 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     Tejun Heo <tj@kernel.org>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] firmware: arm_scmi: Fix incorrect alloc_workqueue()
 invocation
Message-ID: <20230421094804.7mbo37msebzaihq2@bogus>
References: <ZEGTnajiQm7mkkZS@slm.duckdns.org>
 <ZEJNU1om5IhQHB2J@e120937-lin>
 <20230421092742.jjr4gnkswj22yt76@bogus>
 <ZEJZqYfNbyrFkqWY@e120937-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEJZqYfNbyrFkqWY@e120937-lin>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 10:38:49AM +0100, Cristian Marussi wrote:
> I though so, but as usual I am not sure what to do when we are fixing something
> in the middle of a cycle... Raw support went in v6.3-rc1 and we are now in
> v6.3-rc7, so if you want to pick this up now (as it seems the case) it will fix
> the above yes, but it is anyway still on an unreleased kernel...so nothing really
> to have to apply on any early stable kernels...buh..I dont know what is the rule,
> but the Fix tag seems harmless ... so why not :D
> 

Not that complicated TBH. If you know this fixes a particular commit in the
tree, just add Fixes tag. The stable maintainers have made it easier in
general by relying on the fixes tag and not needing explicit stable tag in
most of the cases. I will add it.

-- 
Regards,
Sudeep
