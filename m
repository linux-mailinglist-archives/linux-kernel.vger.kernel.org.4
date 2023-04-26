Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA3A6EFDBF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 00:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239994AbjDZW6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 18:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240477AbjDZW6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 18:58:02 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094003AB2;
        Wed, 26 Apr 2023 15:58:00 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1a5197f00e9so60898025ad.1;
        Wed, 26 Apr 2023 15:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682549880; x=1685141880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UnwIOhGkuLaBbl9w7Be9qPcJQ9Y9ui6c1mraZVmd2dw=;
        b=g12eVio6oB0+C4ec/weafutXhKAEzNho2q5/z5cUMC8Q0nFqHodVk9Po5lDMLdM78x
         y2r01EMpDYhG5HygXISaHP/F0MMMuLvmV0jSLjR9x5xHEcVbnCzVqYtdg+uoANr3zIIg
         XmtR6llax9sWnj+hZoVb+HCIO3Il/EYcRnmOCMsePJBDxyJ7Ey4c4cKEejvQewYD9YgT
         qrrIZLYqUs9SbmKjb8QTi+8PYpvvOTlZcOCOXpvH421JbwMczBP9CbS/A7eGI3dcYfx3
         LpeKNz5OmFBDvJWMoC0JgaaQ57kHSDq/ZXhUJyLEVKmYQfSWQhcig1/xRp2z5AV4PFjJ
         UX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682549880; x=1685141880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnwIOhGkuLaBbl9w7Be9qPcJQ9Y9ui6c1mraZVmd2dw=;
        b=kB6aPvesUONIa/GmSO6IHeET6e3tesHqZI5PRtuimXth+eUaLEF3k0ymC5dAJfhBj8
         9OqYek78YTo4ZXvw7K34JLzcIO2SWsE+7qeb7YKEBiscmTuv1+hTG52fK905Lbo8r1QH
         5Oud0HbmN8OFbknOjqVwyXDb+/zrnRcqLn92Qc5aZMA4V0iSyAnu+meXmL6ceXap2h9M
         6jXdZrYOuYvvFgwlHfYQ6FRI4v9UWPZjHwUqs+E//IPUujwX7GQHthXF1RvMCRrUQ8oj
         5pjzBGY/OEc405IdasbUp5HOxFhWDy12qMNFEZU97aEURPn63oS+qS1GiCFLsRRkQl0n
         Jz+w==
X-Gm-Message-State: AAQBX9dKBxyUNfjqWoz7Cld3glYsyAnXxY4UFDgYhBx1Djax9guJYas7
        Qydr+/koqydWNJNK+7LNFgY=
X-Google-Smtp-Source: AKy350aaTR+E+2z0v5oYpOGG2Fu3fF+AB5ITQB6lXuauC+m7O+3BWsdGB3/HypvrPXz+Di8ytA4o0w==
X-Received: by 2002:a17:902:c949:b0:1a6:6fe3:df9e with SMTP id i9-20020a170902c94900b001a66fe3df9emr27420455pla.47.1682549880220;
        Wed, 26 Apr 2023 15:58:00 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:f84b:79ee:8ff:d568])
        by smtp.gmail.com with ESMTPSA id x3-20020a170902ea8300b001a6aff2852dsm10385284plb.148.2023.04.26.15.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 15:57:59 -0700 (PDT)
Date:   Wed, 26 Apr 2023 15:57:55 -0700
From:   'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
To:     "Jingle.Wu" <jingle.wu@emc.com.tw>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        phoenix@emc.com.tw, josh.chen@emc.com.tw, dave.wang@emc.com.tw
Subject: Re: [PATCH] Input: elan_i2c - Implement inhibit/uninhibit functions.
Message-ID: <ZEmsc0HyZuXlJARq@google.com>
References: <20230320011456.986321-1-jingle.wu@emc.com.tw>
 <ZDBKwo4UMUm+TSnj@penguin>
 <000001d96b4b$6b30cda0$419268e0$@emc.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001d96b4b$6b30cda0$419268e0$@emc.com.tw>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jingle,

On Mon, Apr 10, 2023 at 09:26:04AM +0800, Jingle.Wu wrote:
> HI Dmitry:
> 
> > +static void elan_close(struct input_dev *input_dev) {
> > +	if ((input_dev->users) && (!input_dev->inhibited))
> > +		elan_inhibit(input_dev);
> 
> This check is for "only inhibit request", and elan_open() its check is for
> "only uninhibit request".
> Because input_dev-> open() close() will be executed 2-3 times when initial.

I do not see why this would be an issue if what you are doing is putting
the device into a low power mode.

If this issue is about need to re-calibrate after opening the lid on
certain devices, then I think we need to do the same that we did for the
I2C-HID connected devices on Redrix and hook this functionality to a LID
handler.

Thanks.

-- 
Dmitry
