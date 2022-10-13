Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FC25FE15A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 20:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbiJMSfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 14:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbiJMSfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 14:35:20 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4D8183E02
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:31:41 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id h24so1915162qta.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3dpdEUbn/OTeYvWnaZUyOuTNLHktItsuWg+vuHY5pA=;
        b=VXN3Aezxm97EnNaV3OBRqX1v2PsBpVEjeOoXN8ezlwgYeuWVpU+DjC3c1507OJh/HX
         r/94Mv5Uh0mrkeulnNkbCxs+TBXa0Ku63ehwpyTm0oPDQXOaQ54JkK2pt6OfbyAoS+r5
         JxTWKC/in4pC7S3IReUQ9uLv+3nALef5bScnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3dpdEUbn/OTeYvWnaZUyOuTNLHktItsuWg+vuHY5pA=;
        b=vqqrNue0DxalnBM1F1bgwZMs59dWErGW/3/cFtoILLeF6HHFOTL26+1uCyQ4yb8Vwu
         OS46cLFiE7nRMg/wi50S5l2AVeo+Uplf7RjhhGBFS8I8hKD52ony6HCZDJDO7Jm/Zrhn
         sORHCehVLfYLKM4ROwWn05pzSptiMMdlG3SntoVIXFxexW/jBnkaiDwakgZf4udJmPIC
         80VBWT2nlOrWtmMyxkDcpLmLikA3fbqhfL3UDKMS1I1P9JIPxgZ9gyXpv86ADvFlsiQS
         5MvvKaGrofJqYb68GHzZsxWNlDFWp0+GnuXUZyACW5km7kju9tXF1npBCsOJpBevnMdn
         i4Hw==
X-Gm-Message-State: ACrzQf03JTIn13WH6MKmmZ5xuF4T7hr4oSUK1wkyWFL5cPYVbhRufpl2
        837lvMwNgRg8tPnF9GrdUFLzNA==
X-Google-Smtp-Source: AMsMyM6Mjol3A6+Pe6JYOY/IlpJerCZLtG3UnEytAQ2jzPzuq3Q03zxO12sVTgbIrYSKRfGI8ddB0Q==
X-Received: by 2002:a05:622a:5c8:b0:39c:c83c:ae29 with SMTP id d8-20020a05622a05c800b0039cc83cae29mr1039351qtb.190.1665685838779;
        Thu, 13 Oct 2022 11:30:38 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-33-142-113-79-147.dsl.bell.ca. [142.113.79.147])
        by smtp.gmail.com with ESMTPSA id r76-20020a37a84f000000b006cfc9846594sm325450qke.93.2022.10.13.11.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 11:30:38 -0700 (PDT)
Date:   Thu, 13 Oct 2022 14:30:36 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-rpi-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel-owner@lists.infradead.org,
        linux-kernel@vger.kernel.org, helpdesk@kernel.org
Subject: Re: Add linux-rpi-kernel archives to lore.kernel.org?
Message-ID: <20221013183036.x7o5oqrswwfvo24p@meerkat.local>
References: <20221012191128.GA3108607@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221012191128.GA3108607@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 02:11:28PM -0500, Bjorn Helgaas wrote:
> The linux-rpi-kernel@lists.infradead.org mailing list is listed in
> MAINTAINERS and is quite active [1].  Once in a while a commit links
> to the infradead pipermail archive [2] (the link in that commit
> appears broken).
> 
> I propose that we add linux-rpi-kernel to the lore.kernel.org archives
> so future commits can use lore.kernel.org links that don't depend on
> infradead.
> 
> https://korg.docs.kernel.org/lore.html says pipermail archives like
> infradead has are not ideal, but I don't have any archives at all, and
> I don't know how to get even pipermail archives out of infradead.

The collector is now subscribed to the list. Once we have the rest of the
archives, we can complete the setup.

-K
