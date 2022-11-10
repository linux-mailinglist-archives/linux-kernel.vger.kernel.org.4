Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E903623AB7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 04:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbiKJD4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 22:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKJD4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 22:56:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A3E13CC3;
        Wed,  9 Nov 2022 19:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R9bwS/U7S7bV0/7KYScNF9R6LQoDUoxJzxINgcOLK3k=; b=rnziAupdKaVrSkWJdztAWl3t29
        Yn19OB1/8PTpNZ/bs8YIMaxByQ+8jW2da9eMRRirQjgNjNIgBGJcfnRSQFvsXJN11QtKZntOn9dlH
        voRh7kroEOSX/g3g8bLI4ua2IPnZP8Y9mPfXJdb32RFsKBHA6P6WArARMYYOSCvnixMG2IMyVmZcQ
        BPY9bWS942C1Z1bk1h/3pr/m/oEsJZTKFh5diJbCCGhTnef3vLnITDxnkJ3qpS0OSZXAIbsbM43Za
        hmTi6/MohzoksbTMyq2t4at/xo8d+ycHXTAPBmVRfcK2vmVPdpmJ404ve/+bPo5eyZexRlUmsAANr
        234IM3Pg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1osyff-002RfX-Ga; Thu, 10 Nov 2022 03:56:07 +0000
Date:   Wed, 9 Nov 2022 19:56:07 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com, mcgrof@kernel.org
Subject: Re: [PATCH v9 1/8] kbuild: bring back tristate.conf
Message-ID: <Y2x2V7QoGQXbzycc@bombadil.infradead.org>
References: <20221109134132.9052-1-nick.alcock@oracle.com>
 <20221109134132.9052-2-nick.alcock@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109134132.9052-2-nick.alcock@oracle.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 01:41:25PM +0000, Nick Alcock wrote:
> tristate.conf was dropped because it is not needed to build a
> modules.builtin (although dropping it introduces a few false positives
> into modules.builtin support), and doing so avoids one round of
> recursion through the build tree to build it.  But kallmodsyms support
> requires building a mapping from object file name to built-in module
> name for all builtin modules: this seems to me impossible to accomplish
> without parsing all makefiles under the influence of tristate.conf,
> since the makefiles are the only place this mapping is recorded.
> 
> So bring it back for this purpose.  (Thanks to the refactoring in
> the 5.16 timeframe, this is basically a reimplementation of commit
> 8b41fc4454e36fbfdbb23f940d023d4dece2de29 rather than a simple
> reversion.)
> 
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Reviewed-by: Victor Erminpour <victor.erminpour@oracle.com>
> Reviewed-by: Kris Van Hees <kris.van.hees@oracle.com>

I don't see the need, see the review of next patch.

  Luis

