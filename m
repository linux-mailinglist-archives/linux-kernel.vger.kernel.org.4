Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25ED072601B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbjFGMzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239335AbjFGMyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:54:55 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303F510DE;
        Wed,  7 Jun 2023 05:54:55 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2568caabfbfso3404055a91.3;
        Wed, 07 Jun 2023 05:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686142494; x=1688734494;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8CgmDlf0cq6Sqd4pFmRDUBPf1SwsQ8Z3qWJ2zWJJYlI=;
        b=mGAb27BuXRnjDmFxpVNHVgmdIscLfF+6wBa7uRkDIxiJZg76NxzVt/EmHMxfc5/8HT
         pg5C6kZ5rkzp8wzhMAE/lSUbeqQmH0sK1SFynW/dfyeFAwywjac3dvnmyScxros4SZGv
         ZDTVeuBXVdJqyguBTAZFHNTrtgyBRgcwcw2l1qS4G8cMvfyf9VVDUkC4jBN1XAH64alc
         tfc2ESEwWcNinutHcDfTEDXwfVesE3NFEg+RBua3fHbxCYfRRyruH3R67F3prIDhLKYy
         LdbqhOCznVcnpES2TiWGbb3pme9rOWwr4vdaM58EMCXCFrnRwjzdGvipQ7C83mPQKsqx
         7PDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686142494; x=1688734494;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8CgmDlf0cq6Sqd4pFmRDUBPf1SwsQ8Z3qWJ2zWJJYlI=;
        b=HxtifKK5YF/DYziICxV4j06m1wg3mJrKDpkEddwkNXOaBTMFkldC/muXLOBDzcTxX8
         +nQkXRG8eti/PMQrss5vM42cmUNIjWPg1VXk6mzEQtAYCC33ocIjz9E+dW8Twg6xkP+3
         tUHho93VnGmDgv5VSVX0KRqgjtQCXFl7pl5VEyIARrEkm9dJo31aC7X91t7J46mQ3Oms
         xAl1WKljJg2D7mwrjnpLjY/CWyDMv844ItlK350xC4xqre9JQFNKX7/c1hUXhQRBi4Kp
         Nt47U5gRHdvYch5oLqLqOF2TOQKGT+Bg4Mw+Q+0L1svCiHGDdGScAIVIRKDjhKQrq3Jp
         zhdQ==
X-Gm-Message-State: AC+VfDzQVoT4j+uSZjPbnFor6XX+/GlF98MAXRn1GaM3ivUa8DerlXsz
        jf9I3GdxgPCb0eBDpMV8RqjrX0tgF7s=
X-Google-Smtp-Source: ACHHUZ7imbfoZSZall8P5De0TLfSC6MEwNYY3S8vU2re+uFFUVkeYibc3v8mjykbDK6r0VASNAGyTg==
X-Received: by 2002:a17:90a:fe8c:b0:259:30e7:7348 with SMTP id co12-20020a17090afe8c00b0025930e77348mr1981379pjb.9.1686142494458;
        Wed, 07 Jun 2023 05:54:54 -0700 (PDT)
Received: from sol (194-223-178-180.tpgi.com.au. [194.223.178.180])
        by smtp.gmail.com with ESMTPSA id m9-20020a17090a3f8900b0025645d118adsm1337877pjc.14.2023.06.07.05.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 05:54:53 -0700 (PDT)
Date:   Wed, 7 Jun 2023 20:54:49 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org
Subject: Re: [PATCH] gpio: sim: quietly ignore configured lines outside the
 bank
Message-ID: <ZIB+GUaa934A4sq6@sol>
References: <20230607065004.37112-1-warthog618@gmail.com>
 <CAMRc=Mf9K=_a=UzmazHF1Qc7XxWfP_qJH2gftPAT0Y=e_3FtyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mf9K=_a=UzmazHF1Qc7XxWfP_qJH2gftPAT0Y=e_3FtyQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 02:50:43PM +0200, Bartosz Golaszewski wrote:
> On Wed, Jun 7, 2023 at 8:50 AM Kent Gibson <warthog618@gmail.com> wrote:
> >
> >
> > base-commit: ba65c79fbb813423e7d42d99375e2045b27958a6
> > prerequisite-patch-id: d89da2e3b7511c5b8132a379b12e4996256ac214
> > --
> > 2.40.1
> >
> 
> I queued this for fixes, thanks!
> 

Oh, ok.  I didn't think it was serious enough for fixes, or I would've
made the two patches a series.  And included a Fixes on this one.

Cheers,
Kent.
