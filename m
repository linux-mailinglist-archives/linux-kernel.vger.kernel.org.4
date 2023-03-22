Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF066C4F10
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjCVPKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjCVPKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:10:08 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B894D603
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 08:10:06 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id i5so27391114eda.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 08:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679497805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WpIyrmn2yFb8HSkTpZJfQ2BkuEU1rXMevxKx3lamqmg=;
        b=T5MC288NL/lXi2UWgAiHdCLCQhsnlEys+1QXJDxx2MWjgiMOHMlcvhlwBPgcLooloA
         f7Bo3IznlofEUy9U5OXYgnwamF/lZBINFQbkTwj7lOZ+3z6axy0TLlJ9eGD8CcPUnAuo
         1u8fKIaecqobshVXhvh66EJEGOe6cTsN5G4GInwcARyp7aksZ/hhShC5+ogX+9+rj4nn
         fTt8pijI1/v2LGZOep/9/Uq3c5qO28jJC6bNrMuNpIkRf3PEi+DIyrcW2M9425AkUHav
         KXyjwogHX9TSQWRSjqTTWt2Pljk+Y6TdUSDNcBOeptw6Xs+/RABkyJWfXfqqZ4K/RIzB
         UhFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679497805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpIyrmn2yFb8HSkTpZJfQ2BkuEU1rXMevxKx3lamqmg=;
        b=K2sLYEBrVl0x5bRA+sfLUbDG2fYG6Nv4cZxwPTxZ+Eeq03SGGvu+QMn05cbzm1LyBb
         m+RADbVEEyKZnYL0DfmrZgfUXRKSo2RBRwZIRdOUPq5cx11jpijqBdE4b2M8h5oWSNj4
         c909x0+yhR7yWJrUFFHZyNgMwXJ+uqKzuiJ5TcFEMR458Yf+pIvXWIOD5wKNcTW5An//
         2AGJfgEqBihA6BJjfKjiy5s1jQl5sSbYOaAaUhH0NFcTuTHk1wfpcKZn/+0Alwzd0pp6
         EJe/cZR6EokmQWdAHVQjBZeeTJYK6esSsdDzwutw0i+uqG2ExaJMl5mGjTeWU7QMCluh
         UXwA==
X-Gm-Message-State: AO0yUKW4poIuu51noPGmsm6L1xZw8HEXOjiuuviZ14c7r6DNX7zz7lld
        45B+eph9WE05nO4csZisk/M=
X-Google-Smtp-Source: AK7set/+HAwc3ol55++pC5qAbN6sTJOLggPjQR56N/dbXUzk7LLWy8+z/QEw//cs0aJ/7eJAnJ9Y4w==
X-Received: by 2002:a17:906:2dd0:b0:932:c315:b0d with SMTP id h16-20020a1709062dd000b00932c3150b0dmr6794406eji.34.1679497804580;
        Wed, 22 Mar 2023 08:10:04 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id b1-20020a1709065e4100b008ca52f7fbcbsm7338533eju.1.2023.03.22.08.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 08:10:04 -0700 (PDT)
Date:   Wed, 22 Mar 2023 18:09:50 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
        Christian Gromm <christian.gromm@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: most: fix line ending with '('
Message-ID: <8064a4ee-665b-417e-a1e2-7e7dd32ec1f0@kili.mountain>
References: <ZBsYYAc1Ue/JnUAm@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBsYYAc1Ue/JnUAm@khadija-virtual-machine>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 08:01:52PM +0500, Khadija Kamran wrote:
> Splitting function header to multiple lines because of 80 characters per
> line limit, results in ending the function call line with '('.
> This leads to CHECK reported by checkpatch.pl
> 
> Move the function parameters right after the '(' in the function call
> line. Align the rest of the parameters to the opening parenthesis.
> 
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
> 
> Changes in v2:
>  - Changed the description
> 

No one replied to the v1 of this patch so it's not clear which of the
patches should be ignored.

Also you have a couple patches with the same subject and that's against
the rules.

regards,
dan carpenter

