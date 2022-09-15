Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5C95B96D3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiIOJAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiIOJAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:00:37 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43BF14010
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 02:00:29 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id q62-20020a17090a17c400b00202a3497516so14572204pja.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 02:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=yVCLZymkDZaWtxR0MNc+zLjIKkCSRMaWEa+EeRCKnmM=;
        b=dwS6es3AJ+BLIMYIUPbZDti8uwoPuGw1K86yTn14ak5NfLQbsR14T5dQdL954Ixv+D
         VyOt93yLXL1L2HtoRLAkSsprycIcLrOnnp/lXu1itwU/Fk613/p1txSfzR7gD7238GpL
         EcMbMiMvGt54SpLL5OKI7fVT/y23466rrTaz7lON+01USKt7cqqemxCGt/zwuvkNPvUH
         HJH+IWAEHexuB9Dy4R/WBWxv1hAyRgM8QwhY4xMXSoenyLUcjNRP5W9Xjp8h/meBpl17
         8f5smvhoDOwPsfR57y0EyzLX4EOwjxDnYLsegz6C5iEUDBcfIuwU7DWLJW9XG1qoQjzO
         DD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=yVCLZymkDZaWtxR0MNc+zLjIKkCSRMaWEa+EeRCKnmM=;
        b=MqCQxFoo4kYO3OkG1D/gKYIJMvN8P5qpGHdrQUHGC9HKGi9ZCpqz4hMBvDHvfMwNY0
         En/vUHBjT5rxW6xRs7ywQs2BSfc54u5/3cJrlcpwoivimFxR0ER/alPSnUC8LwsK8Ep0
         9+NGLj+gbjG4UZ4biGGb7rgZcGeHR9ZfoMSJdUwMHuNm6Q28SU5b8dg4zbjb+Lh3GcwI
         DtDLEj1xY91FE7H6sr2B5vRqlfTpYJRWZWPCNOLVcUKIwO7XMMwBdVlh49+1gb2QSlg/
         z3Q2NIV5A5ePXpkI3T4LlrP39QNDvX1E+G1kQBiLBb5gf+I0Wjo8aIGLdUv77BYhRix3
         gK9g==
X-Gm-Message-State: ACrzQf0mFrC7i0EHqKketmUWacwv5ER066tjJvpoAID/Y+POAX4474aE
        qepaqB3wvVVTviWk6pfc6xA=
X-Google-Smtp-Source: AMsMyM4EdA8YCfUrWvPsPb30MArQlPgwgQunnHDATBkKIRBr1nRVIsfw6BwBxK2vCwVVFc6UP9FBHQ==
X-Received: by 2002:a17:902:70c6:b0:173:c64:c03b with SMTP id l6-20020a17090270c600b001730c64c03bmr3212726plt.34.1663232429179;
        Thu, 15 Sep 2022 02:00:29 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id cp16-20020a170902e79000b0016f8e8032c4sm12281063plb.129.2022.09.15.02.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 02:00:28 -0700 (PDT)
Date:   Thu, 15 Sep 2022 02:00:23 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, laforge@gnumonks.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Paul Fulghum <paulkf@microgate.com>,
        akpm@osdl.org, Lubomir Rintel <lkundrak@v3.sk>, imv4bel@gmail.com
Subject: Re: [PATCH] pcmcia: synclink_cs: Fix use-after-free in mgslpc_ioctl()
Message-ID: <20220915090023.GA112572@ubuntu>
References: <20220913052020.GA85241@ubuntu>
 <a8a9fd74-4ee5-4619-8492-be7139e6d48e@www.fastmail.com>
 <20220915020834.GA110086@ubuntu>
 <f41c2765-80e0-48bc-b1e4-8cfd3230fd4a@www.fastmail.com>
 <YyLcG1hG5d6D4zNN@owl.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyLcG1hG5d6D4zNN@owl.dominikbrodowski.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 10:02:35AM +0200, Dominik Brodowski wrote:
> Actually, I'd prefer to apply a patch to fix this now-known problem first,
> even if we deactive / remove these drivers immediately afterwards.

Ok. A patch for the synclink_cs.c driver was submitted first on this mailing list, 
and the other two will be submitted soon.


Best Regards,
Hyunwoo Kim.
