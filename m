Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D116437D5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 23:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbiLEWP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 17:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiLEWP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 17:15:26 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06153FD16
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 14:15:26 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id gh17so1853074ejb.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 14:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zamXeam1VeIeggifJ5GOOWVrNzqJw8U6YgcWunmxdZI=;
        b=h8/53zGuh3NJo5m+HjnOirsSzWmwta9DV39yHLdUaegbigSP8aS3m9jYqf9Gs4BgUp
         vm2K/C6Bc6TS/S2h5/7w54dNJmyPiGeM903N1LGpqx2Yo54QAMWrAjOVRrMPnDzv8idH
         +nQnW9n/MSQOj+eyHkDHfIZ58GWOzTiAwUkXXeFnUdgLM71yz/5s/LaQqAkNZw07K7MX
         kF+1Odpdiv5OyvEThncbJAXqmeup9V94g46YxYzVzZS9EvbOxHMzHAVektknOnE8BNex
         OC42YsQ79Sr1q9e4J/tQFxSRZTZGzi90c6H04bzRPsLpCnsOwYxhKFIaHeQuKvMuA/dW
         Lo+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zamXeam1VeIeggifJ5GOOWVrNzqJw8U6YgcWunmxdZI=;
        b=no+65jetOfybdHRdSFmB9QTfOQ+Df/LFeNQenq0nSv+T6D/7r6A5Qjk3xN+syY38JU
         /eh/q/mhS3P6rarG1sdAmBmZiRQMNZPErjfBOCuT4cu+zh2SPjxfRkiFUdmXLpUiHtiE
         Un4dlv8GFCSEb6yIlTsYigFyduO5vR4HA9XOjljprjGWCG7wCVydeu277ny1mTLo4Kpm
         aLEdn3Oah8WUfVM53bAkf4N5Yz7iqCm2ZK2Mmx2HPKSgnLlQ6bGv9bpzMv0cQF7sdrW6
         SN9ZJ6x76WKr9RejCecW0ZCSLO+DmP6GgnMvfTZIJHxGT/EgCtAtVTC2zhkT1a9KhgPB
         H2Iw==
X-Gm-Message-State: ANoB5plYjIK1/gOGBygq0usLImpivLAjWri2z0dQe6O9ZVKI2vMNz+Nl
        ayrzWlghUKKyFQLezuK3H1EYOe2WWaEFGgIZ9/4=
X-Google-Smtp-Source: AA0mqf7Tf7agS1Cwcn3glcraelH+i9a+VizdXXztMnhOL0ZWpVwpKN8cBDTXb+QxSNVTNuoV7oMzblhSkeEaSbD1dR0=
X-Received: by 2002:a17:906:2604:b0:78a:d0a4:176 with SMTP id
 h4-20020a170906260400b0078ad0a40176mr72663414ejc.720.1670278524374; Mon, 05
 Dec 2022 14:15:24 -0800 (PST)
MIME-Version: 1.0
References: <CAEYL+X_X7OsP3BQ3poK4n+DWEOxAais6d9At9nz2TzLFV2HinA@mail.gmail.com>
 <1716b73b-77f4-da8e-801f-7521872697bb@infradead.org>
In-Reply-To: <1716b73b-77f4-da8e-801f-7521872697bb@infradead.org>
From:   Zopolis0 <creatorsmithmdt@gmail.com>
Date:   Tue, 6 Dec 2022 09:15:14 +1100
Message-ID: <CAEYL+X8KAg58c32LXL8ksfxnDvPPLwJwBRxMFdu6wB7HU+kXBQ@mail.gmail.com>
Subject: Re: PATCH [1/2] gamecube/wii: graphic quantization registers driver (GQR)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> and lastly, gmail has (apparently) munged the whitespace in the patch
> so that it is awful... or it was never done correctly if gmail didn't
> munge it.

In that case, would it be acceptable to send the patches as attatchements?
