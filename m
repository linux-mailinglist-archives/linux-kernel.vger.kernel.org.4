Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D47678B02
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 23:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbjAWWsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 17:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjAWWsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 17:48:12 -0500
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4256193E8;
        Mon, 23 Jan 2023 14:48:11 -0800 (PST)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-15ebfdf69adso15844712fac.0;
        Mon, 23 Jan 2023 14:48:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLY8RW32rwEhutW4QSKC4kVBWVABKzaUeIrAg8svjiY=;
        b=TUzuBRh08JBcuAftnikjg4bOBK3tM7u5rqnJVJjPX0r4sBcir3U51oq0Xbk1J1kFCp
         s3nJyL0Uv8OaRE3N9Ul0a85fyFNFlpV0/fmJajCXFIdrE5IqI1KoRPZsTuIVL0NwKCGf
         VycZLgjtumUPJyjn/zlyGsB28hssQucPteafOD10DsqjDGqnjbPXHk+01L2glkeoOUee
         dN8c0LLJN4pQdtSgP+7bWVk3XhcyXM9pBMibwJBLXiAv6bJoVYFtTb190omDEY51ICx/
         WBzqSXh9C0i+YEXpRm9Q1ud8Cmg9cm2A9JU71Be+tHFocsXp/mwbEDbC6Z78f5wUOtUO
         7kng==
X-Gm-Message-State: AFqh2koPcZTR+tPS2XiTKwmFW8c3/BgxKuA/z7QR8DS4fPjf3RzpIL97
        pYjfGxxi8QZ9kr093d7/s/G1eLLfpg==
X-Google-Smtp-Source: AMrXdXuICNQsmXcCTB7HLvgclBre1OSyKO424I5jUUaxqYvxt76gRz0hf+7fBoC38MaTiAaY8BlROw==
X-Received: by 2002:a05:6870:44c7:b0:150:329c:84f0 with SMTP id t7-20020a05687044c700b00150329c84f0mr13850950oai.45.1674514091001;
        Mon, 23 Jan 2023 14:48:11 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z14-20020a4a984e000000b004fca8a11c61sm161428ooi.3.2023.01.23.14.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 14:48:10 -0800 (PST)
Received: (nullmailer pid 2777713 invoked by uid 1000);
        Mon, 23 Jan 2023 22:48:09 -0000
Date:   Mon, 23 Jan 2023 16:48:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Shravan.Chippa@microchip.com, paul.j.murphy@intel.com,
        daniele.alessandrelli@intel.com, mchehab@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, sakari.ailus@iki.fi
Subject: Re: [PATCH RESEND v10 4/5] dt-bindings: media: i2c: imx334 add new
 link_freq
Message-ID: <20230123224809.GA2738495-robh@kernel.org>
References: <20230121033713.3535351-1-shravan.chippa@microchip.com>
 <20230121033713.3535351-5-shravan.chippa@microchip.com>
 <ec897c39-b6df-82fc-bd9e-84c6213acb1b@linaro.org>
 <PH0PR11MB5611EE968D282A9F998A2F8C81C89@PH0PR11MB5611.namprd11.prod.outlook.com>
 <be218243-a2e7-d9d0-bd7f-ba3c18846f75@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be218243-a2e7-d9d0-bd7f-ba3c18846f75@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 09:00:30AM +0100, Krzysztof Kozlowski wrote:
> On 23/01/2023 07:28, Shravan.Chippa@microchip.com wrote:
> > Hi,
> > 
> >> -----Original Message-----
> >> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> Sent: 22 January 2023 07:37 PM
> >> To: shravan Chippa - I35088 <Shravan.Chippa@microchip.com>;
> >> paul.j.murphy@intel.com; daniele.alessandrelli@intel.com;
> >> mchehab@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> >> shawnguo@kernel.org; s.hauer@pengutronix.de
> >> Cc: festevam@gmail.com; kernel@pengutronix.de; linux-imx@nxp.com;
> >> linux-media@vger.kernel.org; linux-kernel@vger.kernel.org;
> >> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Sakari
> >> Ailus <sakari.ailus@iki.fi>
> >> Subject: Re: [PATCH RESEND v10 4/5] dt-bindings: media: i2c: imx334 add
> >> new link_freq
> >>
> >> EXTERNAL EMAIL: Do not click links or open attachments unless you know the
> >> content is safe
> >>
> >> On 21/01/2023 04:37, shravan kumar wrote:
> >>> From: Shravan Chippa <shravan.chippa@microchip.com>
> >>>
> >>> Add new supported link frequency in dt example.
> >>
> >> You got a comment to fix you CC list. Why not follow my feedback?
> > 
> > Based on your previous comment I ran the below script, rebased to the latest code and based on that output I have added a CC list
> > But I missed adding one name to the to-list which is  "Rob Herring <robh+dt@kernel.org>", I will add it.
> 
> Which is quite important...

Not really. I've long since given up trying to filter based on that. The 
DT list vs. to me is about the same firehose. Expecting senders to get 
it right or figure out what's important to you or not will never happen. 
With lore now, there's little need as I control what I get or not.

Rob
