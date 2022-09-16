Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA4E5BB490
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 00:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiIPW5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 18:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiIPW47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 18:56:59 -0400
Received: from alln-iport-8.cisco.com (alln-iport-8.cisco.com [173.37.142.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4934A6C0F;
        Fri, 16 Sep 2022 15:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1247; q=dns/txt; s=iport;
  t=1663369018; x=1664578618;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XPfewIDcEztVz8CVeYI2ZFWuT7eoBXu50vErkadwthw=;
  b=P/gHJJ7COb58FDHt82eFQnxBawovIQmxioF5U1YlaWWPzZJMfN7yViCB
   R7VdJlNWh8tQtvpTFCzD3GpTqNLwLzBRMpvmF8i5IBipTJZMeZ080Ef2Q
   rwLUlnZ9vtcBQF81uwrkNS1TRt/YQudT5y4EN+SFXPnt0edM5GnxAxncH
   g=;
X-IPAS-Result: =?us-ascii?q?A0AeAADH/iRjmI9dJa1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYN5PpYnA5FmiyoUgWgLAQEBDQEBQgQBAYFTgzIChGoCJTYHDgECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEDAQEFAQEBAgEHBBQBAQEBAQEBAR0ZBQ4QJ4V1hkMBA?=
 =?us-ascii?q?gM6PxALDgQGLkkOBoMQgyEDqDZ4gTOBAYgdgWUUEIEZAZAjJxyBSUSEPz6EK?=
 =?us-ascii?q?oZWBJkEOANFHUEDC0I1GAMUAwUkBwMZDyMNDQQWBwwDAwUlAwICGwcCAgMCB?=
 =?us-ascii?q?hMFAgJNOAgECAQrJA8FAgcvBQQvAh4EBQYRCAIWAgYEBAQEFQIQCAIIJhcHE?=
 =?us-ascii?q?zMZAQVZEAkhHA4aDQUGEwMgbwVFDygzNTkrHRsKgQ4qKBUDBAQDAgYTAwMiA?=
 =?us-ascii?q?hAqMRQEKRMSLQcrcwkCAyJnBQMDBCgsAwkhHwcoJjwHWToBBAMDECI9BgMJA?=
 =?us-ascii?q?wIkW4EwKAUDDRkmCAUjFh4ECD4CBQaaVh98XwJZCmAYo2yeWYNggUeMO5IXT?=
 =?us-ascii?q?BGDZaUNlwqiYYRbAgQGBQIWgWgDMIFbMxoIGxWDI1AZD44sDQmOTiRsAgYLA?=
 =?us-ascii?q?QEDCYsLAQE?=
IronPort-Data: A9a23:Z/cuBaNYBDz9BjvvrR1Ol8FynXyQoLVcMsEvi/4bfWQNrUpz0mBSy
 DMcXjiGMvbcYjGnKN10aIvgoEsBu5HQztNkSnM5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCcaphyFBcwnz/1WlTbhSEUOZqgG/ytU4YoBggrHVU+EHZ410o58wIEqtcAbeaRUlvlV
 eza+6UzCHf9s9KjGjtJg04rgEoHUMXa4Fv0jHRnDRx4lAO2e00uMX4qDfrZw00U7WVjNrXSq
 +7rlNlV945ClvsnIovNfr3TKiXmTlNOVOSDoiI+ZkSsvvRNjhAy3qEFFPcxVXlGgT64mYFS1
 +tmhKXlHG/FPoWU8AgcewNTHyc7Nqpc9fqYZ3O+qseUiUbBdhMAwd03UxpwZtJeq70xWD0Vn
 RAbAGhlghSri+uwwb+/VeBEjcU4J86tN4Qa0p1l5WCCVat3GM2SE80m4/dBxCsCq8JJFMr4X
 NFecyVfUgXmXRN2bwJ/5JUWxbf02SaXnydjgFaUo7cnpmve1gp81JDzP9fPPN+HX8NYmgCfv
 G2u12j0HBAROcCFxDet7H2hnKnMkDn9VYZUE6e3ntZwh1eThWAPIB4bT122pb++kEHWc8pWL
 VAZ/is166E06EutT97gdx6/pmWZuh0bHdFXFoUS5huK1aPS70CdB3MYZjFEYd0i8sQxQFQXO
 kShhdjlA3lkt6eYDC3b/baPpjT0Mi8QRYMfWcMaZTcF797dgIwesizeRN1SFv+WkePeKAill
 lhmsxMCr7kUiMcK0YCy8lbGny+gq/D1ougdu1u/soWNs14RWWK1W2C7wQOBvKofdu51WnHE7
 SZbw5LBhAwbJcvV/BFhVtnhC11ACxytCjzXgVd1E4Im8VxBEFb8INgAuVmSyKqVW/volBfza
 0PV/AhW/pIWYz2hbLR8ZMS6DMFCIUnc+TbNCKm8gjlmO8gZmOq7EMdGPhT4M4fFyxRErE3HE
 c3HGftA9F5DYUid8BK4Rv0GzZggzT0kyGXYSPjTlkr5iuHDPybOFOtfazNii9zVCovZ8G05F
 P4CZ6O3J+l3DIUSnwGOq9dIdABWRZTFLcms8Jw/mhG/zvpOQTF9VKC5LUIJcI1+lKMdjfbT4
 ny4QSdlJKnX2xX6xfGxQik7MtvHBM8nxVpiZHBEFQjzgRALP93whJrzgrNqJ9HLAsQ5k64tJ
 xTEEu3daslypsPvoW9FNMOj99IyKHxGR2umZkKYXdT2RLY4LyShxzMuVlWHGPUmZsZvifYDn
 g==
IronPort-HdrOrdr: A9a23:4xM42q2wdZKm3DocpQlwfgqjBIkkLtp133Aq2lEZdPWaSKOlfu
 SV7ZEmPH7P+VQssR4b8+xoVJPsfZqYz+8Q3WBzB8bAYOCFggqVxehZhOOI/9SjIU3DH4Vmu5
 uIHZITNDTYNykcsS4/izPIaurJB7K8gcaVuds=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,321,1654560000"; 
   d="scan'208";a="930591598"
Received: from rcdn-core-7.cisco.com ([173.37.93.143])
  by alln-iport-8.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 16 Sep 2022 22:56:49 +0000
Received: from zorba ([10.25.129.98])
        by rcdn-core-7.cisco.com (8.15.2/8.15.2) with ESMTPS id 28GMukaE015046
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 16 Sep 2022 22:56:48 GMT
Date:   Fri, 16 Sep 2022 15:56:46 -0700
From:   Daniel Walker <danielwa@cisco.com>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh+dt@kernel.org>, xe-linux-external@cisco.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver: of: overlay: demote message to warning
Message-ID: <20220916225646.GK4320@zorba>
References: <20220907230709.271889-1-danielwa@cisco.com>
 <973f7127-8165-45f6-071f-04360046b7d7@gmail.com>
 <20220908003510.GE4320@zorba>
 <c0c66918-f55e-83e4-edea-b2d32fdb27a7@gmail.com>
 <3fcea82c-f5cf-f066-67b9-08669c44a9c6@gmail.com>
 <20220912170524.GX4320@zorba>
 <75e803f8-2b25-22c8-0831-e90d0c889da1@gmail.com>
 <20220913005153.GZ4320@zorba>
 <00850627-7ada-3a02-158c-30f3b8334d51@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00850627-7ada-3a02-158c-30f3b8334d51@gmail.com>
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.25.129.98, [10.25.129.98]
X-Outbound-Node: rcdn-core-7.cisco.com
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 05:47:54PM -0500, Frank Rowand wrote:
> > 
> > Maybe you could add a flag or other indicator which would indicate the overlay will never be
> > removed. Then your code could rely on this property to inform on if the author
> > has consider the removal issues related to overlays.
> 
> No.  I guess I wasn't clear enough above, where I said:
> 
>    "And I will not accept a
>     change that suppresses the message if there is no expectation to remove the
>     overlay."
> 
> There are multiple reasons for this, but the most fundamental is that if a
> new overlay is not removable, then any overlay already applied can not be
> removed (because overlays must be removed in the reverse order that they
> are applied).  It would be incredibly bad architecture to allow an overlay
> to block another overlay from being removed.

So how about an option to turn off removable overlays entirely? As far as I can
tell it's not used currently by the tiny number of implementation I've seen.

Cisco doesn't need it, and we could have a smaller kernel without it.

The issue is that the error log on blast is log level abuse in my opinion. If
there's no way to fix it, it should not be an error.

Daniel
