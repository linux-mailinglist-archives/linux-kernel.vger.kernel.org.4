Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26506681AD6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237511AbjA3TxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbjA3TxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:53:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05D64ED3;
        Mon, 30 Jan 2023 11:53:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7EF9BB81689;
        Mon, 30 Jan 2023 19:53:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE31C433EF;
        Mon, 30 Jan 2023 19:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675108391;
        bh=8zlI9aX1N49T0MYlxinfKaNPhz4QTQRZioihuwzrMDM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kjcs3x9qAYFwI/kCEBObIX7v+j2rpw23nbJNcUGBEMINvopnL9u/S+rjP1otQBnSl
         QyEgku6IEfZGAHNSKYmpG5bXxQNAui8DyycZeBowclE8g0foDr1YhWcpF6ZFAJ3z/m
         X3GQsFnQauRP0u1OER6viwD9oJb6GLyKX3TytEXZ48sPRHBLb04gFL+BVfh+HihgDA
         UFyQGMVnjb1zCIEYjaVM+bGxJ+PABHcOIvsCdjoFcRD+v5kIZeOt6AT6nkjwGo2DQq
         RKo2Z6lavsAC2Q7LjRr/R07lMRoDV30H4qUOTtdBnCxB30oQ8zJOpIH9cucmajFAjj
         +y+Xj0Dn9vuJA==
Received: by mail-vs1-f52.google.com with SMTP id j7so13718645vsl.11;
        Mon, 30 Jan 2023 11:53:11 -0800 (PST)
X-Gm-Message-State: AO0yUKUPMekEgg0hptWHJ3x2Jo07Pp5+PGSK6bokiVzUX56LcJJz7MuC
        VoEFyo1Fur8SBLRNqd6RDony26I3OdZst9jJCA==
X-Google-Smtp-Source: AK7set8fFL3zBqYlQdY0u7dmCurFObMNP2O53UQEuYSzkKOCYh+xT4NHlzqp2dA6Oe2XAUjxln8to9PrmxtiHVDPR/c=
X-Received: by 2002:a67:7144:0:b0:3f3:5ce0:85ab with SMTP id
 m65-20020a677144000000b003f35ce085abmr1252830vsc.26.1675108390153; Mon, 30
 Jan 2023 11:53:10 -0800 (PST)
MIME-Version: 1.0
References: <20230130162650.399490-1-masahiroy@kernel.org>
In-Reply-To: <20230130162650.399490-1-masahiroy@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 30 Jan 2023 13:52:58 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+e15e64Vsg8SwDsrUfzS8rWKi_39ajp3=2Ck7Dz_gs5A@mail.gmail.com>
Message-ID: <CAL_Jsq+e15e64Vsg8SwDsrUfzS8rWKi_39ajp3=2Ck7Dz_gs5A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: rename .yamllint to yamllint
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 10:26 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> This file is ignored by git by the '.*' rule in the top .gitignore.
>
> I do not see a good reason why this should be a hidden file.

Only because that is the default name yamllint will pick up if it is
run from the bindings directory. Not really something I do though.

Rob
