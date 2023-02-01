Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DEF6866BD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjBANW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjBANWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:22:51 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC555206AC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 05:22:49 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d14so17288655wrr.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 05:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yQsTT7vzEv2btlkh6hAE9R2TMqftLVwRfIlZmCyBNZ4=;
        b=ObeEnKk3ZN9uzXVtLvh0MFNQR/+WxPcY4FvzCab4X0MGlPdZSUy3gmObjKOve07PE7
         YPJtuFqgvXnaEnnQizzr8+FdlJsb3Pftjy6r6xbalhpTRev+5eRW7gUS8D0MBRhYswGG
         qj/1WpLyBJM1GD43luSHyr1wPMU1kWM/kztHhr0B+dUpjIqRlaki3dBYZM3zdfwRez5h
         0rflqUrAgUbJwGiDYHgEsGKl+/Otdwxo+G2XWLEDpGjkCDXpdDbvvpvfbTRa29mP5lV5
         jftA5JfCWHiR4Yk86Iq59W77u6BTRG3yeh684RzhVP5i6Q71WgJ4n/ZWDoHoDsGC+cbk
         DYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQsTT7vzEv2btlkh6hAE9R2TMqftLVwRfIlZmCyBNZ4=;
        b=Wz7hCqRyQqYr9AEXy/0wWU6I6jMkhrV+70dB7wlh0Xi+n6fmbWSvY7sTT3hFUd/2I6
         KrYJx9t47zB2UUWUS3GJYEp443x6yKqZYOVOVVwY9gwGenJOoL58b/z61eUIsV5Vfa2H
         q9G0NVVqc1vPJpzicuwG+JIuHG1Ay4XkHSQlXX/BCGen9HQd37ikqaqnXJH0CVJxYR24
         Ozo7Gbhm+IdmtX23LkSdmiBSJxcs8pRYZ+SnEqwQ+hBdh0I0hshDKsJJzC6YRaFhmz/r
         OADK31bpfTVUU/pL7p1nWs4o/ME8xOw93xHPNKUYfp0ecTMa6pABR0fFhe5XBHRfydE8
         XRFg==
X-Gm-Message-State: AO0yUKWFCv+1fNLtLbp1d+n76aezJFxSYxP2IF2UM7cpptIEz1YKVBM1
        HLICo2r7m6hjnNjugnDFLeN9iaGZ818=
X-Google-Smtp-Source: AK7set8617xhhvfVL6x561L03xUlErWEyI0KsbQ4bh1o9aPwd8pdzJJQUkKMSnlzhu9d3E4JWEeJwQ==
X-Received: by 2002:a5d:4103:0:b0:2c3:733e:cec3 with SMTP id l3-20020a5d4103000000b002c3733ecec3mr2292900wrp.15.1675257768176;
        Wed, 01 Feb 2023 05:22:48 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m17-20020a7bce11000000b003dc492e4430sm1789256wmc.28.2023.02.01.05.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 05:22:47 -0800 (PST)
Date:   Wed, 1 Feb 2023 16:22:43 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Guru Mehar Rachaputi' <gurumeharrachaputi@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: pi433: modify bit_rate from u16 to u32
Message-ID: <Y9pno7gZHa+r/Rg3@kadam>
References: <Y9h42l/8EcPqn63x@combine-ThinkPad-S1-Yoga>
 <Y9ilj812USHrSXe+@kroah.com>
 <Y9jrOKMGl7ITKxhP@combine-ThinkPad-S1-Yoga>
 <19e492521b4a4d31aa13c45e8616689b@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19e492521b4a4d31aa13c45e8616689b@AcuMS.aculab.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 12:34:50PM +0000, David Laight wrote:
> In reality having a uapi structure with embedded padding should
> be banned.
> But that would need a compiler attribute to enforce it.

It would be simple enough to grep the names of all the UAPI struct and
use pahole to make a list of the existing structs which have holes.
Then re-run the script every week and complain when new holey struct
types are added.

You could do a similar thing with Smatch looking at copy_to/from_user()
struct types.

regards,
dan carpenter
