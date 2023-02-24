Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2116A210B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 19:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjBXSBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 13:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBXSBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 13:01:10 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66131ACED
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 10:01:07 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id y19so8920pgk.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 10:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gc0wK4nqkzBiU7HZwNBVhdP/h5JAiovM8WNF6ypvC+k=;
        b=nWPVVwIzE3s8aQ3O/ykJmrns2yClCg7RP0O2XZmVFcBptqc80DXoe4At4hJp+W+Y/V
         Op/yI83VeNIk0Cuxp/Ttq4wJOENa5e2I2woPlRkDpbl8lXxD3ZsarhFKgGXpbgSi3tIB
         lM8ggMVPw727wHUn0v1U4EBAJyRmxEb5aIQNvcS4Y9LtoX6eDzrfP5hEIrKIoODxCr3X
         hInfKU2EC14sA1sDw4kIQBqVQ/zVz+vfUQTtLltWNfnTR1Q90HFAOOgoBrQ6Q1ppf85o
         9rq8/nraWNrWXrGwz2Pi06c9ETnPlDchu+j50fe3e0/Rs+Ba4yuojwctuOVjBeERPd0M
         Fdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gc0wK4nqkzBiU7HZwNBVhdP/h5JAiovM8WNF6ypvC+k=;
        b=7exFXjSDpOaEYDUZ9Xq0GprULjxoxFVTFWuf5RRSi9TSFIGWjnQEItyW3JJ11Xozvi
         HNcZ1EFaqTpx+MTyyXfG76MQJuZYczToJVt7RJDpckDruDIJKZx1+CIS2pu/fMIKAQjg
         7sOKzw7OWmt3dAFxkOCRQibzUUHthpBplA7e95ps1ijAm/D2oMTMRSAUVd9gbm0Fkc6E
         fGgtkF/Ma611gXjoasE8THVqIiLbJJKOJjXartmjHN3UMd5+pxpKOL7o5SeBf6pbqTS6
         QysCzWP3OzYBJeu/1e49gJxoP0HTgp7juAKutmA7eLRvwMTJ5NwD1Z7zt5ksmRRzYwO1
         XlGw==
X-Gm-Message-State: AO0yUKX9DH9dSSi93vb/jtRId3dsliad/RYf1ILVvUHSf5kBlIyyQUhx
        yt4PKQgAiEhdyfuUmnd2A61iRvlwPmn4mlH4p/jbTA==
X-Google-Smtp-Source: AK7set9R3qytEv1+MlUWgPB/B1OQOIkSTmGriaigFodwxFRkOSja10y0TsqOzX+ltIGP3aC+M5CTsATguCEE1dkxGr4=
X-Received: by 2002:a62:8602:0:b0:5df:9809:6220 with SMTP id
 x2-20020a628602000000b005df98096220mr1629514pfd.3.1677261666202; Fri, 24 Feb
 2023 10:01:06 -0800 (PST)
MIME-Version: 1.0
References: <f4d6ddad-90c7-8a59-4f1f-334ae5e38463@inwind.it>
 <Y/j1qPOZm90d7Oi1@1wt.eu> <e49d167f-f418-f2a5-ffb0-6c7f7ea5b74f@inwind.it>
In-Reply-To: <e49d167f-f418-f2a5-ffb0-6c7f7ea5b74f@inwind.it>
From:   Slade Watkins <srw@sladewatkins.net>
Date:   Fri, 24 Feb 2023 13:00:54 -0500
Message-ID: <CA+pv=HNUMqtFGEdcsgxEq6+UpqVj95o89rc4D7zSJyGnvHLHNw@mail.gmail.com>
Subject: Re: Bugzilla 217083
To:     Valerio Vanni <valerio.vanni@inwind.it>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 12:53 PM Valerio Vanni <valerio.vanni@inwind.it> wrote:
> Thank you, I reposted. I don't report bugs often, so I probably miss
> something. Now I'll try other versions, collect more data etc, but it
> will be enough to update bugzilla case or should I update also mailing list?

I'd say both. We've got a whole thread on bugzilla and not all
developers here on LKML use it. (Some do, though.)

Ultimately it's up to you.

-- Slade
