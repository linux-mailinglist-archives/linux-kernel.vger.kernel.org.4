Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7EC695CDD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 09:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjBNIZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 03:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjBNIZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 03:25:41 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECD12724
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:25:40 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id bg5-20020a05600c3c8500b003e00c739ce4so10901711wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hZn1g1BxSoyDoGO08JTTlZgpJYzAyAHcNUx33niXmng=;
        b=JDcLbhmYNfsn0i8C2ASO7x8qyQmYjnCZgP4WoyveSnnqCkDb+KzJD+Z2fhOsrGPJgf
         W1w9kf2KB6BJxKsJ0HfA52crgUjmbG8xqALdbVztTxXkx295e6tu0ZtR/7uMTFDswSir
         tKf/awKE3bHfAtWTpqiCptrXWn8sj9lqhxab9G+1sSRwb7CcL+GFvw1Sij2694SVIEXc
         Mi6zejpHVDdUxtzzyERRDzp7i0ihUvLBbQFUw3qPYseBhUoVTkJSIFPE1e5miosyuJPV
         2YvJVE5Pt54SuQ3wkHy6TU0rUTCkFLtn4ZRULSlAhiug+3BwX56fyJo9ZY4dbQbSs+J6
         Lt8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZn1g1BxSoyDoGO08JTTlZgpJYzAyAHcNUx33niXmng=;
        b=HlY3KRVOPqTp+0v1Vzizj900ylSlq0Lbg19llxJa4Xe2VXctqMYfobKFmHlxfdvICQ
         ZZNcsgJsSVZxEpjvb+daxm6Gieh0sdWpcXQFKDomsCbWAcoCgOxBWm1y7sgT4QzN6yG7
         U/coyadcnZl9MTTohUzVJa19zQZRkfHrdBn6BeFSWHDCl7aIpwxs3DvEYSAdmG6RYktE
         w3qRcBvDKOycVBMPHFm7Z3KweuzODIyEetxODNyyCelj9lD7HpinG/ferEgzCqGVgi11
         ipMlIiJCqdJKnlxRdalKinDrZbLoUntKXnKW5k27aX1GEA76J/zMhOqtsSzMoZ468D2y
         KXkw==
X-Gm-Message-State: AO0yUKWyf/LyaLEI7TtJOrx/P5mCxagAlJMG8RuDRxPm9zz/G3QAj/7H
        x+ALiPdDEJP4z11ZhnfAKrQ=
X-Google-Smtp-Source: AK7set/c2JLILyjKx+i3J70UUW0NrcG/g0aClo+B8mFWjoofK5i7EFowng0H8MoZbhDJRliCBv6R2A==
X-Received: by 2002:a05:600c:4d92:b0:3dc:51f6:8f58 with SMTP id v18-20020a05600c4d9200b003dc51f68f58mr1252117wmp.6.1676363138950;
        Tue, 14 Feb 2023 00:25:38 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q14-20020a05600c46ce00b003db12112fcfsm18055916wmo.4.2023.02.14.00.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 00:25:38 -0800 (PST)
Date:   Tue, 14 Feb 2023 11:25:35 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Jacob Bai <jacob.bai.au@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: change (struct pi433_tx_cfg)->bit_rate
 to be a u32
Message-ID: <Y+tFf3dFR812iVbj@kadam>
References: <Y+srSuTdGmzmXG1I@jacob-Ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+srSuTdGmzmXG1I@jacob-Ubuntu>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 05:33:46PM +1100, Jacob Bai wrote:
> Based on the TODO file and datasheet of pi433, the maximum bit rate for
> transmitter is 300kbps when modulation been set to FSK. Hence, the size
> should be u32 rather than u16.
> 
> Signed-off-by: Jacob Bai <jacob.bai.au@gmail.com>
> ---

This breaks the user space API.

The TODO was updated recently to explain how to do this properly.

regards,
dan carpenter

