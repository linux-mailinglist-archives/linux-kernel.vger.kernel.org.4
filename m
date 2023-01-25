Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A923F67ADD1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 10:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbjAYJ3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 04:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjAYJ3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:29:00 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDECAD0A;
        Wed, 25 Jan 2023 01:28:59 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id bk15so45852092ejb.9;
        Wed, 25 Jan 2023 01:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nkDlpiK6JqYBUlqcSfouXIHmsyVu7ZE8aOa2LbX/OX4=;
        b=Ri4Rgc0kjv11SM3M3hT7DgWRg27kM4xn+I+Iu9fv/2DxCZ1O98df8xtCH7mUpgtn+V
         IQ4VK5EdeOlPWgiR5gLUEohgI8wg55mcKkm7AezEm8fXX6x2juyAW6/R0u9kgnd2grES
         POIlAILRgRXTdNVC4ocLKQm6nZCt+ZUZCVFE6l3FRG81l9jYKxbgVv9FcabFT9WIFASs
         N1vnulG2h0wZjf0icfD61QAZYoCVzGYEXZR+KAukww+6I48SL01v/AS2h44YpI/xDHKw
         IGRm21wSPcCDcCrnmGstLYtOYcUa6Crk601qzOS/gVrdqF4sg0oZR+YqL9uGQ12ml4y+
         g3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkDlpiK6JqYBUlqcSfouXIHmsyVu7ZE8aOa2LbX/OX4=;
        b=KJ4xTHEU3MJs/Gng9BamOYJciuo3LP83z0mfzMJ2bL8fYBQWvcVjMSZn+mTXqVVKog
         LBV5mH1sKDpvMM4tKTo9+He4UgfzyuVOvT42LvfCAsrdIOtUaHg1fJwngrImf/y5iQ0n
         Ufsp45Kop3Mpx3P2QZrZTP/ewuqLGAXnmUP5aE6m7dD7Vn+64vefd9wtF+XFgENrfdSv
         zWwaHZ1SOfH1n/k2eZCfutN8iNYLzIn0eOLfSpJACeLRfYfULr8XhxfeAklXpojK5yqv
         n+Fi2w7knwTyCdIUwU+omneRVQqgU3y5eTMiwXQAnMw1xkg8ooALzTeS0G+9YgKTQuAz
         TBPQ==
X-Gm-Message-State: AFqh2kodBz6VtbezmjzKFqzJPG22XzUaDHD62ci8NqRLbNRddMSX5q4L
        pufP85lKCcQlTpKGXtAMXxA=
X-Google-Smtp-Source: AMrXdXvtAxeG907Zl+UkNPimfhMuSmIMZLKOu8Yj5pdDBbCXfKLfEuYmeyP7+o4O6IRkylGXMIiXFw==
X-Received: by 2002:a17:906:fc0e:b0:84d:3fa7:12d7 with SMTP id ov14-20020a170906fc0e00b0084d3fa712d7mr31759441ejb.21.1674638938082;
        Wed, 25 Jan 2023 01:28:58 -0800 (PST)
Received: from fedora (176-74-132-138.netdatacomm.cz. [176.74.132.138])
        by smtp.gmail.com with ESMTPSA id jp9-20020a170906f74900b00877800030f2sm2059259ejb.169.2023.01.25.01.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 01:28:57 -0800 (PST)
Date:   Wed, 25 Jan 2023 10:28:55 +0100
From:   Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mani@kernel.org, hemantk@codeaurora.org, quic_jhugo@quicinc.com,
        andersson@kernel.org, Michael.Srba@seznam.cz, arnd@arndb.de,
        dipenp@nvidia.com, bvanassche@acm.org, iwona.winiarska@intel.com,
        ogabbay@kernel.org, tzimmermann@suse.de, fmdefrancesco@gmail.com,
        jason.m.bills@linux.intel.com, jae.hyun.yoo@linux.intel.com,
        gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org
Subject: Re: [PATCH 3/3] wiegand: add Wiegand GPIO bit-banged controller
 driver
Message-ID: <Y9D2V1dz6/+EOa5D@fedora>
References: <20230104133414.39305-1-m.zatovic1@gmail.com>
 <20230104133414.39305-4-m.zatovic1@gmail.com>
 <Y7WwVCqDCXFrTqR9@smile.fi.intel.com>
 <Y7Ww67pIyjeLKBE7@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7Ww67pIyjeLKBE7@smile.fi.intel.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

thank you for the notes, I am working on fixing them. You have
mentioned, that it seems like the driver which should be generic
provides specific functionality. AFAIK, the Wiegand protocol
does not define the payload length of messages. Most devices use
one of the three formats I have implemented - 26, 36 and 
37-bits. If I understand you right, the Wiegand GPIO bit-banged
driver should allow one to send messages of any length and it 
will be up to a device driver to make sure the correct message
length is used. Is this the correct approach?

With regards,
Martin
