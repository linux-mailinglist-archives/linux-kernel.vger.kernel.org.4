Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80CB6819C8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbjA3TBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjA3TBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:01:41 -0500
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2363757F;
        Mon, 30 Jan 2023 11:01:38 -0800 (PST)
Received: by mail-oo1-f44.google.com with SMTP id 123-20020a4a0681000000b004faa9c6f6b9so1395915ooj.11;
        Mon, 30 Jan 2023 11:01:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7PNJxFH7gDdMse434RHu5JL4B3ooE6c7lUdvQTDPn8=;
        b=4hdsU3YS6iHph1fOhh14QSy77ozyKQgy0TACmhPl1RSVjl5ZU+el1VZkZ0/qvCFw9t
         fGYso/0xcCjsIEludcnyf9E6H58LaD64TQ35E3Sb9IH84nla9Yoq/zzqugeXJ0Ln2z1r
         hvh7EfINTtb/2dqqZOEgNJjsz7bqANLciQjs+S3aUUAGdBStoJb6DSl61UH6jKNxZIZP
         bKpr5/a/Csc0KKjkizUyDA7xDAMXwphHkpOy0JAoQ+FgNriJ4qoHrZhhFCR469wq8131
         xa0ZUVX7XjGSoiPqPtViP6EwMIUd4I1SQyFiQpW7GYOC7+Iwgiwwp39CaVnpbvnzn0Hu
         s/Xw==
X-Gm-Message-State: AO0yUKUZVoKG595nRLORYNNhETwZUpvvcJAmu1+54Fds+DjZUdrW7E1r
        iBq+gS42RN/Ou//XSQIjhA==
X-Google-Smtp-Source: AK7set97447YafxHmlkxrDII2zwtdplxGb4q+5/7vfjzRM46vNJPfFHa7ECNiIQqZTPgAbRKA+zFug==
X-Received: by 2002:a4a:346:0:b0:514:d8f0:45b0 with SMTP id 67-20020a4a0346000000b00514d8f045b0mr6845375ooi.2.1675105297531;
        Mon, 30 Jan 2023 11:01:37 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w6-20020a4ab6c6000000b004fc4000ae48sm5252918ooo.15.2023.01.30.11.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 11:01:36 -0800 (PST)
Received: (nullmailer pid 3121442 invoked by uid 1000);
        Mon, 30 Jan 2023 19:01:35 -0000
Date:   Mon, 30 Jan 2023 13:01:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rayyan Ansari <rayyan@ansari.sh>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, asahi@lists.linux.dev,
        dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, janne@jannau.net,
        David Airlie <airlied@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v4 2/2] dt-bindings: display: simple-framebuffer:
 Document the panel node
Message-ID: <167510529465.3121384.11904840013697184141.robh@kernel.org>
References: <20230126182435.70544-1-rayyan@ansari.sh>
 <20230126182435.70544-3-rayyan@ansari.sh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126182435.70544-3-rayyan@ansari.sh>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 26 Jan 2023 18:24:35 +0000, Rayyan Ansari wrote:
> Document the new panel node and what it is used for.
> 
> Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
> ---
>  .../devicetree/bindings/display/simple-framebuffer.yaml  | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
