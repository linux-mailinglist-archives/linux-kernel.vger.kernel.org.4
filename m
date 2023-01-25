Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4C667B385
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 14:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbjAYNhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 08:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbjAYNhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 08:37:36 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031CE366B1;
        Wed, 25 Jan 2023 05:37:34 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id mg12so47700139ejc.5;
        Wed, 25 Jan 2023 05:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FGZhhsvD8+TQGlEbFXQhClVyxy7cnFPOZ3OksWnERd4=;
        b=FMhX4qVIJUl8wQB544nU5iRXOltV/J6nYBFsQd1f44MT9NNt26E6t0yU518C5ZTnYv
         fT3Vo5gnKTEO6/BSKd46JYn/SgJrpkrmViAZRdUkzYe3Eyzdo8vqxnUrBAJKP8iu+xqF
         YNYDTBrUHRwhggU1t6sXogMBR0j/IhNsT4PvPb5CyaguXlS/LlPxxmXBoIyBAHor7b4d
         +sifvxx/wrJTA5/reGcBssY2Y4wGiKKOj2W9CbcZc0rT6Xl15/CbM4F266MvmD5QLGP7
         kiHsnrOVr6TMR4j7eZf/W6PHEKc8nAvivR87saB2vpKwwgE72sqBuRFRIJpNZhZEKm3z
         8zgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGZhhsvD8+TQGlEbFXQhClVyxy7cnFPOZ3OksWnERd4=;
        b=BQ+5TMHrktS2vlFvHpgrZyVkceSBPTkRmXp/04SzwVDfA98Oe66UBF+b/ig3Tt5KXP
         bcn8AIgt3bBxBpfK1HHvvRTliH45nkS9O8PNPNj4EzH21GfBu57R4WjC4Zwo7B3WrpM7
         f0e1qgADx/nacJXsBngD4fNqyRkjXJnyTPprttMgBRDXfzlOAbRpeIwdNHsWSLeyWNfc
         0Tjfj5RNKyIgKNmIv2BbkS2WjBr9fuhsvDOeUVmd2nfQgx7sPoms0wNFZWGUdaUcuMLF
         GhZjSgpoWU/IKJw6AtC8NQUK+lrHZJHeAXI7zQ77uISP2rcXiRWc2EewSt8Wor7A6jb3
         hxqg==
X-Gm-Message-State: AFqh2kqPgQ63hM9VQ4zI+q2zHPkD+p8lcp6WzbMqyfWpXAXDL5tWFW0u
        /mQsq9hkrrYH6VhPAACCG+A=
X-Google-Smtp-Source: AMrXdXtHu/X+yu1d8gTj6hiercOSjzVtHpNWuOyfLzScQKZvCGxLRq7WryD7DFvsocN+mk4vqdIMFg==
X-Received: by 2002:a17:906:c7cc:b0:7ae:bfec:74c7 with SMTP id dc12-20020a170906c7cc00b007aebfec74c7mr33164552ejb.72.1674653852388;
        Wed, 25 Jan 2023 05:37:32 -0800 (PST)
Received: from fedora (176-74-132-138.netdatacomm.cz. [176.74.132.138])
        by smtp.gmail.com with ESMTPSA id m11-20020a1709060d8b00b0084d1efe9af6sm2373904eji.58.2023.01.25.05.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 05:37:31 -0800 (PST)
Date:   Wed, 25 Jan 2023 14:37:27 +0100
From:   Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mani@kernel.org, hemantk@codeaurora.org, quic_jhugo@quicinc.com,
        andersson@kernel.org, Michael.Srba@seznam.cz, arnd@arndb.de,
        dipenp@nvidia.com, bvanassche@acm.org, iwona.winiarska@intel.com,
        ogabbay@kernel.org, tzimmermann@suse.de, fmdefrancesco@gmail.com,
        jason.m.bills@linux.intel.com, jae.hyun.yoo@linux.intel.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Subject: Re: [PATCH 2/3] bus: add Wiegand bus driver
Message-ID: <Y9Ewl37xP9+b2cek@fedora>
References: <20230104133414.39305-1-m.zatovic1@gmail.com>
 <20230104133414.39305-3-m.zatovic1@gmail.com>
 <Y7WHjD4psjgAAyPd@kroah.com>
 <Y9EpNfZJ5irXZqvR@fedora>
 <Y9EuCGT2KkGfYrVf@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9EuCGT2KkGfYrVf@kroah.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am sorry, I should have included more information.

Anyways, Arnd Bergmann has been kind enough to give me more
insight and I now understand the point you were making in
the review and will fix it.

I will be careful to include more information in the future
communication.

With regards,
Martin
