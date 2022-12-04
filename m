Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09936641DC2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 16:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiLDP5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 10:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiLDP52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 10:57:28 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8844713DE4;
        Sun,  4 Dec 2022 07:57:27 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-14449b7814bso5918591fac.3;
        Sun, 04 Dec 2022 07:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FyUJ55Sp6NTcNHyrCAOg3Qy3ojALWHQaCDx2qeVIGFE=;
        b=FJ08/nDh+VX9AcTeeEpyzkQOXquevy43Xc5vX3mnBhSqeP2oR8FQqlNTxw6ZUZFJFW
         UW8eA/RXbT++pYEZxaOI0Xu6k6GhOUHurejutzsP6u96GTw9kGnUTO+ZcVBxg6ylQowf
         1ikQlbdIcYHfIR2p3RH3ozUMIxaUOXiOgwe8FQo6Y7aitruZfH0542pTSQBWmx3PCxN6
         P6TCY/vaOCAuKYF0I5Wsog5Gudf60tOreEfN6GEkz9xHogOoTeWxyePNMgFi/KxI4Uw7
         9thAL+YWJzVY4Bxc2kPC9A9S8rlrAGXuZhRbh2dKpMWeUCBi3jjonQvW2HYMVi0xQlMr
         Tu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FyUJ55Sp6NTcNHyrCAOg3Qy3ojALWHQaCDx2qeVIGFE=;
        b=uUxMM6PWEOWnf2vLP2dqN/sYdnlKmz7h2pW2mlxa3VqtViDU8zPOPV7C25BOFaBtB7
         TCievTbIiDjQfuHil8z1RWmQY9y0KJPIPljiv88ijOtW5VrlX9u1aluAg78fgOae+Q5k
         kix5WAYeLOouKb4PGRQ1Q5J/O9AgYMUI+BYYgMV6Dvau5gYuyE4fvbytSYVETedq+lZV
         GjeqHzchCstNZeLyMAOjFwds8UhrL3V6CLf4VvT3+dkYifwryGZiPUrfqJ426DVZfMIz
         k0sEpx1Z/IQqyhdCKAsp1ZGFVnXXlnAvCyi0+bcPCPzUz1dxhGCWi9CKdBNURxldMJz6
         0gWg==
X-Gm-Message-State: ANoB5pnUXmNA+tWa1bfl5ELZpOTHPV5El/8XQ/DN4G51IDD2Lj+b2cxq
        jobrQtHLucqJuFKSMj9Y49YXUMuo7aA=
X-Google-Smtp-Source: AA0mqf52rHfzoFHFG2J4DRKrHZrLvWSu7NJsPXtMPzrFNrnoXYYKnuRS92qh8N53Tbqb9j4B7rpZWg==
X-Received: by 2002:a05:6870:788b:b0:144:7b84:e08 with SMTP id hc11-20020a056870788b00b001447b840e08mr2310025oab.201.1670169446809;
        Sun, 04 Dec 2022 07:57:26 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id by13-20020a056830608d00b0066e873e4c2csm3372715otb.45.2022.12.04.07.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 07:57:26 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 4 Dec 2022 07:57:24 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Badhri Jagan Sridharan <badhri@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH v3 3/3] usb: typec: maxim_contaminant: Implement
 check_contaminant callback
Message-ID: <20221204155724.GA1862600@roeck-us.net>
References: <20221204084844.3573800-1-badhri@google.com>
 <20221204084844.3573800-3-badhri@google.com>
 <Y4xrpgCTqV4yAplp@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4xrpgCTqV4yAplp@kroah.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2022 at 10:43:02AM +0100, Greg Kroah-Hartman wrote:
> On Sun, Dec 04, 2022 at 12:48:44AM -0800, Badhri Jagan Sridharan wrote:
> > +EXPORT_SYMBOL_GPL(is_contaminant);
> 
> Sorry, but this is a horrible name for the kernel global namespace.
> Please properly prefix it to show exactly what subsystem this is from.
> 

I don't think this needs to be exported either.

Guenter
