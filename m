Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA629698F93
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjBPJTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjBPJTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:19:08 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF65F4ED3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:19:06 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 62F1B220CF;
        Thu, 16 Feb 2023 09:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1676539145; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QdPKsuBsKRQyH26rQ/iwv7qWwXEhtn8YG/jmVX744W4=;
        b=2L9T8LAR6X8aMZKR5yKXzuKNMT/rW5rjNw0BH8w6MSHW7NbkF1RyPLm4RcX2uC+/jIHGpM
        WFnSxJvT46wyxmqc3A4nyUUbzlc2Bly5hDZ0gpbxCyXgFcMWGqiAF/dWKhbfoqBvtiBFx5
        rdKplv5n+qHk+XC4XBCpqt4lCtnm60o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1676539145;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QdPKsuBsKRQyH26rQ/iwv7qWwXEhtn8YG/jmVX744W4=;
        b=sPRZ1s/1aYUt2uWrwurZ3IcLDE7cMRI617rpchfwPfWWebejyI4xXUymk5lLNj7BmCG+R5
        XfkeA+ZmC6IhqbCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 33D6A13484;
        Thu, 16 Feb 2023 09:19:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jzVACwn17WMEJQAAMHmgww
        (envelope-from <jroedel@suse.de>); Thu, 16 Feb 2023 09:19:05 +0000
Date:   Thu, 16 Feb 2023 10:19:03 +0100
From:   Joerg Roedel <jroedel@suse.de>
To:     Thierry Reding <treding@nvidia.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>, iommu@lists.linux.dev
Subject: Re: [PATCH] iommu/of: mark an unused function as __maybe_unused
Message-ID: <Y+31B7SN+IUgdWxC@suse.de>
References: <20230209010359.23831-1-rdunlap@infradead.org>
 <Y+TO0yEdUNzWUUrA@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y+TO0yEdUNzWUUrA@orome>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 11:45:39AM +0100, Thierry Reding wrote:
> Maybe this is one of those cases where we should wrap after the return
> type/attributes to keep this somewhat readable?
> 
> Either way:
> 
> Reviewed-by: Thierry Reding <treding@nvidia.com>

Wrapped it around and applied the patch, thanks.

Regards,

-- 
Jörg Rödel
jroedel@suse.de

SUSE Software Solutions Germany GmbH
Frankenstraße 146
90461 Nürnberg
Germany

(HRB 36809, AG Nürnberg)
Geschäftsführer: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman

