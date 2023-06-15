Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DAE730DFD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 06:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242934AbjFOERX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 00:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242904AbjFOERT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 00:17:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE7110A;
        Wed, 14 Jun 2023 21:17:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5CDD60ECD;
        Thu, 15 Jun 2023 04:17:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF432C433C0;
        Thu, 15 Jun 2023 04:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686802637;
        bh=Wf7Wd81kwURj9/QONfqCGAHz6JBdBCub1nSOGMdDMA4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VcZufbfQCdXJzbcHg9NKloFUyJfXTJBoos26D/HEYloKrBGr7N5O9FuhPL2ET4HhM
         E1oCxT4LMBe00RplzvezqEHpXG39/ki0nUsMO+zGFuMJPAVXilKM64QoZfjya/uq8k
         s0fTInSgOpQHrwtLj9nAl2dFCHD8YptM9mTi7v1rIr87LCgIsAJ6jsX44zYF+1+Hmy
         uCf77Z1ze7nz6xzI7dK8j/L3niRaLjR4r0C/0pdVlKf79F0wVig25eGvI23tzRdqqE
         uIF3fXywF8zlOVy6YJte6po3PJcI2B/QW/bGe7jbPXoG8W4C/KjWQr/+CfKIBrDeF+
         kzwXTElbSH/ow==
Date:   Wed, 14 Jun 2023 21:17:15 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next] tools: ynl-gen: generate docs for
 <name>_max/_mask enums
Message-ID: <20230614211715.01940bbd@kernel.org>
In-Reply-To: <DM6PR11MB4657A5F161476B05C5F8B7569B5AA@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230613231709.150622-1-arkadiusz.kubalewski@intel.com>
        <20230613231709.150622-3-arkadiusz.kubalewski@intel.com>
        <20230613175928.4ea56833@kernel.org>
        <DM6PR11MB46570AEF7E10089E70CC1D019B5AA@DM6PR11MB4657.namprd11.prod.outlook.com>
        <20230614103852.3eb7fd02@kernel.org>
        <DM6PR11MB4657A5F161476B05C5F8B7569B5AA@DM6PR11MB4657.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2023 22:11:38 +0000 Kubalewski, Arkadiusz wrote:
> Thanks for pointing this, but it doesn't work :/
> 
> I tried described format but still ./scripts/kernel-doc warns about it.
> Same as 'make htmldocs' does, as it uses ./scripts/kernel-doc
> 
> Also, if the enum is not described in the header, the docs produced by
> the 'make htmldocs' would list the enum with the comment "undescribed".

Oh, you're right :S Looks like private: does not work for enums.

> It seems we need fixing:
> - prevent warning from ./scripts/kernel-doc, so enums marked as "private:"
>   would not warn
> - generate __<ENUM_NAME>_MAX while marking them as "/* private: */"
> - add some kind of "pattern exclude" directive/mechanics for generating
>   docs with sphinx
> 
> Does it make sense?
> TBH, not yet sure if all above are possible..

Let's ask Jon, and wait for him to chime in, I don't think these
warnings should be a blocker for new families.

Jon, we have some "meta" entries in the uAPI enums in netlink 
to mark the number of attributes, eg:

enum {
	NETDEV_A_DEV_IFINDEX = 1,
	NETDEV_A_DEV_PAD,
	NETDEV_A_DEV_XDP_FEATURES,
/* private: */
	__NETDEV_A_DEV_MAX, // this
	NETDEV_A_DEV_MAX = (__NETDEV_A_DEV_MAX - 1) // and this
};

Also masks of all flags like:

enum netdev_xdp_act {
	NETDEV_XDP_ACT_BASIC = 1,
	NETDEV_XDP_ACT_REDIRECT = 2,
	NETDEV_XDP_ACT_NDO_XMIT = 4,
	NETDEV_XDP_ACT_XSK_ZEROCOPY = 8,
	NETDEV_XDP_ACT_HW_OFFLOAD = 16,
	NETDEV_XDP_ACT_RX_SG = 32,
	NETDEV_XDP_ACT_NDO_XMIT_SG = 64,
/* private: */
	NETDEV_XDP_ACT_MASK = 127, // this
};

which user space should not care about.

I was hoping we can mark them as /* private: */ but that doesn't
work, when we add kdocs without documenting those - there's a warning.
Is this a known problem? Is it worth fixing?
Do we need to fix both kernel-doc and sphinx or just the former?
