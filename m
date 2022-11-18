Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E18A62F74B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 15:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242350AbiKRO2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 09:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241762AbiKRO2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:28:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE89B72081;
        Fri, 18 Nov 2022 06:28:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A37D9B82435;
        Fri, 18 Nov 2022 14:28:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E64C433D6;
        Fri, 18 Nov 2022 14:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668781698;
        bh=T7HfDD46P7xE4VMoR6Z9Idk9G+uS3S4T34Q+NY3qED4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bvCer4rZc7rfSEwdcLtiju0mxO7RP/vXYXSCIpX+DB85cYFmQm88jOuHifqfDaeXT
         uR1yS4xUX3W2Se6ZBRRKW5ta53DEwh/w/lSK92QssTX7cTqqP+rJo2Ybs993aCzRPO
         +LWHhZLvse67PQyIBANHYWBSAvTk9oZRRRLWnF+6BnlmPBNlA6Br+H1JspyH1qUZeE
         cIlKway3Xb9zabik6lO8wK2yCYx+boYTs/ylaO37cosVzzcDI5qg0Xz8/cLtN+4J7S
         HZrgB3Hf3UyL/L3iPuW07Ui+UqzDlCgeakhqYNkRlg5sGslUi5G0KqHIxCImWIORk7
         KL3c7Y8hld58w==
Date:   Fri, 18 Nov 2022 14:28:12 +0000
From:   Lee Jones <lee@kernel.org>
To:     Guenter Roeck <groeck@google.com>
Cc:     Mark Hasemeyer <markhas@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Raul Rangel <rrangel@chromium.org>,
        Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        chrome-platform@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 2/3] dt-bindings: mfd: Add DT compatible string
 "google,cros_ec_uart"
Message-ID: <Y3eWfOUdcElS9cun@google.com>
References: <20221117114818.v7.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
 <20221117114818.v7.2.I9e018ecb8bdf341648cb64417085978ff0d22a46@changeid>
 <CABXOdTfB9DA1LX3qj4QiHdTuJwV_OnP3eUEyTUvHzX3L3jnkNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABXOdTfB9DA1LX3qj4QiHdTuJwV_OnP3eUEyTUvHzX3L3jnkNA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2022, Guenter Roeck wrote:

> On Thu, Nov 17, 2022 at 10:49 AM Mark Hasemeyer <markhas@chromium.org> wrote:
> >
> > Add DT compatible string in
> > Documentation/devicetree/bindings/mfd/cros_ec.txt
> >
> 
> This is now google,cros-ec.yaml

Also there is no need to repeat the filename in the commit message.

We can see that in the diff-stat below.

Please come up with a more imaginative commit message.

Exactly what are you doing, why you're doing it will do.

> > Signed-off-by: Bhanu Prakash Maiya <bhanumaiya@chromium.org>
> > Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
> > ---
> >
> > Changes in v7:
> > - No change
> >
> > Changes in v6:
> > - No change
> >
> > Changes in v5:
> > - No change
> >
> > Changes in v4:
> > - Changes in commit message.
> >
> > Changes in v3:
> > - Rebased changes on google,cros-ec.yaml
> >
> > Changes in v2:
> > - No change
> >
> > ---
> >  .../devicetree/bindings/mfd/google,cros-ec.yaml       | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> > index 04962bb29576e..26787e4574b8d 100644
> > --- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> > @@ -28,6 +28,9 @@ properties:
> >        - description:
> >            For implementations of the EC is connected through RPMSG.
> >          const: google,cros-ec-rpmsg
> > +      - description:
> > +          For implementations of the EC is connected through UART.
> > +        const: google,cros-ec-uart
> >
> >    controller-data:
> >      description:
> > @@ -222,4 +225,12 @@ examples:
> >              compatible = "google,cros-ec-rpmsg";
> >          };
> >      };
> > +
> > +  # Example for UART
> > +  - |
> > +    uart0 {
> > +        cros-ec {
> > +            compatible = "google,cros-ec-uart";
> > +        };
> > +    };
> >  ...
> >

-- 
Lee Jones [李琼斯]
