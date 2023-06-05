Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7697228CE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjFEObM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjFEObL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:31:11 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1975799
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 07:31:09 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-656923b7c81so869773b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 07:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685975468; x=1688567468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gELTh+lV9q4NwQCYqns3mZpnGKP0tZeTzTj7DkVh+4s=;
        b=Pd0P+Hit0bFO+tQ89ijcJoUs1ct5aHPs5HRT1sG0V9KnY3t5sC/UHwE7GZIPtnuJSH
         2R9i14Q+/mns30cReSo4+8BaGRD3yI+eZ2GAVYg1vqSu07O1FFdG2WsPcCEYttr13bIM
         8Ps0D9+YfYlXfhuwKDeFtTjrryliE9SPWNgtWkDDPuU4KDYeQyl4KK1EAO9fhvduSv7b
         7LQoKhclXdv+MyyPoWUnJKD6DLxezntBqj6qhne4jTDVMw9/xQSD0RhZT7+IZ5UjzbwG
         +CMKG9IwYqIILb2/qedCyqIcWPaFbd4JWUMstkg3uqA5bC3Ft7/RNdxNK4TO1bpJfylH
         6Hrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685975468; x=1688567468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gELTh+lV9q4NwQCYqns3mZpnGKP0tZeTzTj7DkVh+4s=;
        b=dl8cOG2oeEPN6IikEGTlU3G4EkEUqa1lMgLh0w8fBLPQYg9Rw4wdGKI1oM9eQ2wkFT
         wNcB/9LaJbp6p1md+A8gh+merGdjYCoZbMqlGg7dTFiHXynM6iIwV4UEA8FybFCGlKZ7
         r0BeUX2BZP0ja+4EJIUx3AJMOAwzuXQ5tjwdbtkj9abNwf/mIbkXH/9KXmLbPK7LMnXz
         KyP2AQJKW9YO8aG/XuctA7kyaYa4TAGY7Ds7SxEVHxb3Qu1m0wxTUid8EcgBonq/xS9r
         Am1T6Oev9EJXtiIXabl2yG6KgMk9zL4f5n2ss/0yr1qIYXwGODIXga1CsHkaLBzxEYoj
         YGVg==
X-Gm-Message-State: AC+VfDw45osWq2tPeH8PNHFMH+XQLECjy5Bt9fhr6eUGXZPqX88QjJ4i
        1qySMhVatdPOUxFdZR2BSug=
X-Google-Smtp-Source: ACHHUZ4v9Jmy46Ni5J/QrpEU9YjeX1oWYPvcuphF35eV8mgPAPBdi0VIVrpHeAiJ6hAYI+yxQ1vEIg==
X-Received: by 2002:a05:6a00:b91:b0:65b:cc73:1074 with SMTP id g17-20020a056a000b9100b0065bcc731074mr1316559pfj.23.1685975468443;
        Mon, 05 Jun 2023 07:31:08 -0700 (PDT)
Received: from pc ([2405:201:2003:b135:89cf:b185:51e1:ed4b])
        by smtp.gmail.com with ESMTPSA id a17-20020aa78651000000b0063d670ad850sm5485293pfo.92.2023.06.05.07.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 07:31:07 -0700 (PDT)
Date:   Mon, 5 Jun 2023 20:01:03 +0530
From:   Raag Jadav <raagjadav@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] regulator: act8945a: rely on hardware for operating
 mode
Message-ID: <20230605143103.GA3068@pc>
References: <20230605104830.68552-1-raagjadav@gmail.com>
 <04b8fa24-e5a8-4871-a397-f1c0c886449a@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04b8fa24-e5a8-4871-a397-f1c0c886449a@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 01:16:33PM +0100, Mark Brown wrote:
> On Mon, Jun 05, 2023 at 04:18:29PM +0530, Raag Jadav wrote:
> 
> > Convert ->get_mode() and ->set_mode() hooks to read/write operating mode
> > from/to hardware instead of relying on driver memory.
> 
> Why is this change being made - what is the benefit here?

Original implementation uses drvdata to load/store
operating mode for the regulator.

This change doesn't really add anything new.
It is just to make sure that the driver is in sync
with the current state of affairs in the hardware
instead of relying on locally stored status in the memory.

> > While at it, map fixed-frequency PWM regulators to REGULATOR_MODE_FAST.
> 
> Don't combine multiple changes into a single patch, this just makes
> everything harder to review.

Will split in v2.

Cheers,
Raag
