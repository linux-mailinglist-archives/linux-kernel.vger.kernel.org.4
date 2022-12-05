Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C500642868
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbiLEM1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 07:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbiLEM04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:26:56 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A5B5F8E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 04:26:56 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 463CB3200942;
        Mon,  5 Dec 2022 07:26:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 05 Dec 2022 07:26:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1670243214; x=1670329614; bh=xi
        Nj68kj+E8I04RquOccPksnaIcx/vzfb5uv8IIux00=; b=DI1NHSMmxG0qrRWAQN
        9aT872w8rr1iiPaLfqh/qZ1XSyStqljS+geqUiVtKtqqa72abPFVi8z/BddmLbMT
        DwqYpITKwGjtp3yL4y+IXQz0+Sk2yeC1Do+P6fEHLQs4WJ1x1L3XK2mK0X5GAeJT
        0blrMne+k7HR5TAdpw8g5dTsYj/5nzLMHC8m6k5Xc8MNTwfbfupGJZ+j9TGN6x6I
        8HZstxl8QX9NJH0J4Cl6plLlE5NnO3iN788OS1QLsddBmccmjUKMAmpyDawSB79s
        K4VOhyQdqmMjFadlio7ENjYzE88Ewc2RN6CwFxj7bWOzk0PcJ6VartSFhZDRODwf
        argA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1670243214; x=1670329614; bh=xiNj68kj+E8I04RquOccPksnaIcx
        /vzfb5uv8IIux00=; b=p5BYjcDXJh8S59EEE/DmVYmburpgAfPUp5T7l8RSphYm
        gTG8wzPEXb+gv0zcnEi2+Rlgap8Rd1Sa8BLKjpWqwNbFbY3LCmkG3X80+nuo67ma
        XxC5B7Wpba6RvEvWoSMliaw1UlOMmJJcehDPNTTsC0fOm9q9MgZoPP/yKhnf/3Bj
        +k7RF0yvG9nq0QVHCFXwLsrX+4zL1FQQ+bpdliyRAQKwEWanzqB+UrbtKlAwybBb
        7J5GRJwHaSN53xPv8rRDnozMdilLiPJqEGdfpXulPycLT777vLRPRZx56ID+CeYm
        DzbJI0T2jMkFr7rzkMco0qE1/aEIOwtWBUTp57Tirw==
X-ME-Sender: <xms:juONYywpurbgApvg_mfjKhsT5ZtKdx9FXqowTerHKC8Oe-617DAZmw>
    <xme:juONY-Qrx3KnCb3WziD9B1v6pkg7OHtcW4hDEY0iEDZV1AhhnDCmQAv_AxwR8rh_1
    MscPsU2K1wDEvNoKSc>
X-ME-Received: <xmr:juONY0XgzPWgcbK49NIbZ-XlGWZJ9y3ZytZq27TLNuNrDrtD31yy6Y1awR3OeZx5QuHVBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeggdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpehkihhrihhl
    lhesshhhuhhtvghmohhvrdhnrghmvgenucggtffrrghtthgvrhhnpeehleevveejudejke
    evueevteevfffhkeejgfehleethefhueejvdehieejgffhhfenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmoh
    hvrdhnrghmvg
X-ME-Proxy: <xmx:juONY4jnOJRNusmf_aVLE_8elINz1CEFLfEBr_Sx19lYVjB_h2v4Vg>
    <xmx:juONY0CJ4tn-4gX_dKPdtTbeWrSq9c7hFdUsDYuuIghGsuzPjWRIsA>
    <xmx:juONY5KMqtRknrJsXC6Ol1fZ7amaGPivtt2OCteGPBql2x3hzhapoA>
    <xmx:juONY20x9KwBIVl71jt6H4viKSOaMqZX_wygjqoymfivALF9h3lUGQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Dec 2022 07:26:54 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 95CD810948F; Mon,  5 Dec 2022 15:26:52 +0300 (+03)
Date:   Mon, 5 Dec 2022 15:26:52 +0300
From:   kirill@shutemov.name
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/2] x86/mtrr: make message for disabled MTRRs more
 descriptive
Message-ID: <20221205122652.ursq3cba4ozysbmg@box.shutemov.name>
References: <20221205080433.16643-1-jgross@suse.com>
 <20221205080433.16643-3-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205080433.16643-3-jgross@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 09:04:33AM +0100, Juergen Gross wrote:
> Instead of just saying "Disabled" when MTRRs are disabled for any
> reason, tell what is disabled and why.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
