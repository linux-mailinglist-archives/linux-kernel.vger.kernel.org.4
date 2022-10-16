Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B769C60006A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 17:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiJPPJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 11:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJPPJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 11:09:15 -0400
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [IPv6:2001:67c:2050:103:465::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B86B42D4C;
        Sun, 16 Oct 2022 08:09:13 -0700 (PDT)
Received: from smtp102.mailbox.org (unknown [91.198.250.119])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4Mr3S46tpPz9tM5;
        Sun, 16 Oct 2022 17:09:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=noorman.info;
        s=MBO0001; t=1665932949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BwnvJmYklKb2+UBlQ9rYbd4a798S+TwPnf4/wOdXb8Q=;
        b=N/if0YtRFwuNvLmMwtm5NHC8Y4mZeD33HEV96X1NJo0JZbbn0QiMD8LeLLSrojqsPRs+JC
        9voFab7Jfd6vb+Ei68y+dOLm6Z0U/OAf8bMIcCbUZy6K7JkzAJrCVL4TUxncLWQs37HbOo
        CtM7rOkZq+WN9j4UhMXu5o0NHsyvktJl8DXX38K33c7KbfmGMwtIMs6P67P+LyFGdlekn5
        uJUnSPl59bw9OTOMLDpNg5qdWyOeMOJdQh8nw9gUk9D+D+dkze/SHSJWSawksFVIPF/dSG
        1TthsSYOXafnTaCQ3tHAGRgkDQrsp08cK65vqM5mbeSvSSNHiL8lVBpQbRt/rA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 16 Oct 2022 17:09:07 +0200
Message-Id: <CNNFXYM20GK5.3O8PV4IRMP2HH@ancom>
Subject: Re: [PATCH v3 1/3] dt-bindings: touchscreen: add Himax hx83112b
 bindings
From:   "Job Noorman" <job@noorman.info>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
Cc:     "Luca Weiss" <luca@z3ntu.xyz>, <linux-input@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221016102756.40345-1-job@noorman.info>
 <20221016102756.40345-2-job@noorman.info>
 <08a98921-592f-fe70-1591-367f9c4063b6@linaro.org>
In-Reply-To: <08a98921-592f-fe70-1591-367f9c4063b6@linaro.org>
X-Rspamd-Queue-Id: 4Mr3S46tpPz9tM5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Oct 16, 2022 at 5:00 PM CEST, Krzysztof Kozlowski wrote:
> On 16/10/2022 06:27, Job Noorman wrote:
> > This patch adds device tree bindings for Himax 83112b touchscreen
> > devices.
> >=20
> > Signed-off-by: Job Noorman <job@noorman.info>
>
> You got here tag from Rob, so keep it. The change was minor so did not
> justify tag-drop.

Thanks for the info, I wasn't sure if this would be considered minor. Will
add the tag in the next revision.

Best regards,
Job

