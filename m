Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069F45FFF09
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 14:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiJPMFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 08:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiJPMFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 08:05:47 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9B92ED44
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 05:05:44 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id x13so5192479qkg.11
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 05:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UmI04icaYYevz8erTj5VumVzXOApiqD62eBBl7puraY=;
        b=qtT0dLgoP8gq5FOWhmRjCFCwDD61Tr+gqDYRdhXsTrxyF5nLMFs7IKgjiOMKH5F4l5
         I5CC/lowN/7J/INdR5JiQGFq9Ao8Q/l3LjpSMAyuFBa+MXQuHNgzwfs7YNblXrBwsWXM
         3VG0q3bZTJrP1RIeTbobQQcBZ9/onb+dz8y0rKuALIc16BZ0o4pdtn4+JzogIOz8tHXo
         jgUM/AY1SpsEQ1uQmmTooVqm1cQ6HmsxLwgb/Mt4QhbyUSLDj/Pr8lqY/5tp+8IC0CBa
         PAKCRY8ozzixXu02pJ5azNoQw5CPV5aXjU9mYIw8pbduoe+Xwrk9Lw8xTf6xH3wXNiFX
         Fd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UmI04icaYYevz8erTj5VumVzXOApiqD62eBBl7puraY=;
        b=M3hmBOhDmALPTHBk/2zbVhdcvAWBEpXa4TNTgFIorkSvabP5QLl/qckyO2ugKcUDkl
         IvT8Rut2Ht7bmHFesdwlNdDa2Xkn25rm0ZoK1hrH/Q6qwHyx8Zhur/EBmdZAVbvraJfT
         jw2o728ppy+lpNsBOcR0XIOpTEjagWly6AQdonv4Dbqc+HYNcc14S0vT+CsyDKpI2v5I
         Wt0xClxKG7TSWnKrlQHzo4kLjjtbJg8yBdcflEN9JTpSzzrkreK5e5sWN7/ubvLoDpRO
         04RaRxKbcnX1yWup9nTVLH1L5blzDQG45uNhQBDGr2Nx/+ukq9iwN2AE/doEVjPGr8sK
         Zg+w==
X-Gm-Message-State: ACrzQf2l1TYuvyOSezsUTR/z9Mp3FokdbsgRGSNyTXpdUFo4w+8BsN4j
        88Hqav3VhCjARvse1zov1wMJZQ==
X-Google-Smtp-Source: AMsMyM7L06TcpOGp8BEqPcSmNwY3HduQhD2Ygu7LrmAfwqVeAp05tdZ+NzI25BMTnWyukqtxML2mhw==
X-Received: by 2002:a37:4553:0:b0:6cf:4dbd:b5f6 with SMTP id s80-20020a374553000000b006cf4dbdb5f6mr4382912qka.339.1665921943627;
        Sun, 16 Oct 2022 05:05:43 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id q4-20020a05620a2a4400b006ec09d7d357sm7187342qkp.47.2022.10.16.05.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 05:05:42 -0700 (PDT)
Date:   Sun, 16 Oct 2022 08:05:40 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     jic23@kernel.org, lars@metafoo.de, benjamin.gaignard@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com
Cc:     fabrice.gasnier@foss.st.com, linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Removing the last of IIO_COUNT (stm32-timer-trigger)
Message-ID: <Y0vzlOmFrVCQVXMq@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HRMrcOk/7EdR9IuO"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HRMrcOk/7EdR9IuO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The drivers/iio/trigger/stm32-timer-trigger.c file remains the last
consumer if the IIO_COUNT type. The IIO_COUNT type was deprecated some
time ago with the introduction of the Counter subsystem. Most of the
previous IIO_COUNT consumers were migrated successfully to the Counter
subsystem, but the stm32-timer-trigger driver remains as the sole module
preventing the final removal of IIO_COUNT.

At the time we deprecated IIO_COUNT, the Counter subsystem was nascent
and lacked some of the functionality we have nowadays such as a
character device interface, timestamping, hardware buffer support, etc.
If I recall correctly, the decision to delay the migration of
stm32-timer-trigger to the Counter subsystem was a lack of some
functionality the Counter subsystem could not provide at the time.

I hoping someone can evaluate stm32-timer-trigger to see if we are able
transition now to the Counter subsystem, or if that necessary
functionality is still missing today. Even if it turns out that we are
unable to migrate, it'll be useful to know what's left to implement in
the Counter subsystem to support stm32-timer-trigger or similar devices
in the future.

Thanks,

William Breathitt Gray

--HRMrcOk/7EdR9IuO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY0vzlAAKCRC1SFbKvhIj
KzBaAP0TAsZHUhqetvOPlAMcDxL+BLNrmOVVk2noaEurAxJBBAEAg3wWG3/TM4jB
pZMQoTnLR84Z69Y4AoEgwfVbXnhPNwA=
=j1dt
-----END PGP SIGNATURE-----

--HRMrcOk/7EdR9IuO--
