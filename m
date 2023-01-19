Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B22F67332B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 08:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjASH70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 02:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjASH7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 02:59:09 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90795AA44;
        Wed, 18 Jan 2023 23:59:03 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id j9so1046288qvt.0;
        Wed, 18 Jan 2023 23:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LmxZN1YrGcXIl6BJ7TKPqUyMt3s9X7GC0r8mhCyLVo8=;
        b=KGyQWSTYSZ34wKgDYbw+kGxfjC+rpxGiKRzBmXLO+hQx8UnwneML37sz4LLXkNu6UL
         xALXkefIx1XI53QROsTnc8672Myaemq0lVzG4fAS2RJUU7+RlIkriHMVvsmy6HKyFzTO
         YH8PwA11Y8GirnFCeDPj1B5ctmqQPG1xPFE77niZ4x9BdzJ/IjV1RBmGU0adQ0P5bh+3
         xY6VYduSdLs4YQ4OwseQLNKXEMmTqfQ7nrP2jESI7Aefa1Zb/EHAH91QhSDDlEdkDv7R
         +MxsBBnbRNucNF2QSuFqLIOyeLLSzjXfxMFdYxL0tTqK2YNPjLOr5OMvHI/Ye9AMURVB
         Z5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LmxZN1YrGcXIl6BJ7TKPqUyMt3s9X7GC0r8mhCyLVo8=;
        b=QxKvFqjnfe+I+exdJjjupm4Cl8d0+ALYqWJA/u0ft3T0FzbBsZ0yTwYGwPRJyiHs4e
         CUIVZ6DRox6ZXzmo9Qpb/XDU1zTHjOC7jdtuhj/SDzTAondxyDlByl0h9cNqYV8pcG6F
         jLH4D7QErk6qOQivC4O1ltDhTJ6v+oZKP3/06AaCvBEdHjCkbvsCP3Rer7xntG1U2qFb
         Nf/8tDnJezhMJ/wLEBSRiReFFWGYoMS6kAlI2WADCgvK2gJDtOqg2qbkRfHFEGdCeXkI
         GO+hWjhgNih00WjTfGivedeA5zv/Q2fRo/wWog+KwSXyhgW27xFo6i5fM1H+NPG7IrBq
         MVTA==
X-Gm-Message-State: AFqh2koWRm70TKPLG5I8WW3lCGAVhwJBgAKLsYCeGwCOwWAkmca5VHxe
        NJyvMgPyRliIwAGRbWGG0/w=
X-Google-Smtp-Source: AMrXdXv+INBpJMonZE+SaI/fxARrwKp0VT1O9hj9jRu8mAkCgF8HYsqZYMOKWAoxLprXrbcGWvUKlQ==
X-Received: by 2002:ad4:52e7:0:b0:531:cc33:19b0 with SMTP id p7-20020ad452e7000000b00531cc3319b0mr12905265qvu.24.1674115142525;
        Wed, 18 Jan 2023 23:59:02 -0800 (PST)
Received: from p200300f6ef015700e657423a1f156bec.dip0.t-ipconnect.de (p200300f6ef015700e657423a1f156bec.dip0.t-ipconnect.de. [2003:f6:ef01:5700:e657:423a:1f15:6bec])
        by smtp.gmail.com with ESMTPSA id 3-20020a05620a070300b00706b69d3414sm2426279qkc.94.2023.01.18.23.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 23:59:01 -0800 (PST)
Message-ID: <bb2e8b7b4ca894ed53d70bf04e2d52bed2553105.camel@gmail.com>
Subject: Re: [PATCH v1 1/2] iio: core: Replace
 iio_sysfs_match_string_with_gaps() by __sysfs_match_string()
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>
Date:   Thu, 19 Jan 2023 09:00:45 +0100
In-Reply-To: <64406c4f-c9da-b434-360b-1050ff685d2d@metafoo.de>
References: <20230118074828.66155-1-andriy.shevchenko@linux.intel.com>
         <5f9b713b-9c71-7da6-e674-b6ebd28dc5d5@metafoo.de>
         <Y8gVDs0UoiHqCRsM@smile.fi.intel.com>
         <64406c4f-c9da-b434-360b-1050ff685d2d@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-01-18 at 08:37 -0800, Lars-Peter Clausen wrote:
> On 1/18/23 07:49, Andy Shevchenko wrote:
> > On Wed, Jan 18, 2023 at 07:22:30AM -0800, Lars-Peter Clausen wrote:
> > > On 1/17/23 23:48, Andy Shevchenko wrote:
> > > > None of the current users is using gaps in the list of the
> > > > items.
> > > > No need to have a specific function for that, just replace it
> > > > by
> > > > library available __sysfs_match_string().
> > > Hm, I specifically remember adding this for a driver where there
> > > were gaps.
> > > One of the DACs. But it might be that the driver itself never
> > > made it
> > > upstream.
> > I have checked all modules that have struct iio_enum and/or ("or"
> > probably may
> > not happen) IIO_ENUM() in them.
> >=20
> > It might be that I missed something.
> I checked too, I can't find it either. The driver probably never made
> it=20
> upstream.

Yeah, I also did a quick check and I could find it in one adc (most
likely we have more downstream users of this) that did not make it
upstream. Eventually, we want to have it upstream but the ABI using the
gaps can arguably be dropped...

Anyways, from my side I'm fine with this change. We can revert it if we
ever have a real user for this. I'll just have to be careful when
updating ADI tree (but that is our problem :)).

- Nuno S=C3=A1
