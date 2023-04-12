Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5F86E002C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 22:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjDLUt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 16:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjDLUtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 16:49:22 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E83659D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 13:49:20 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id r27so16416434lfe.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 13:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681332558; x=1683924558;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8hdZHKFT9Rd4RSuruBi1wtqiU0miv7QXZ4KN0K8fAoY=;
        b=qJCmZYNV/jXDwuU++Bc9PjQ/MaAzizpHw/BR3HlrEK2r7VCpHTQtEkkwyNKLuGTBjE
         Uw7au26Rve4ZW6T38mWibCFRc8VilDixTBzqoY3EUBYUcOdIKjcAFKmjy78XELRWNWjI
         mB5EZM9vGFoCcXQ/oJnLeT+sXusVPtHhqZHC8AkuCr8FUtUv0KtjRHppehlB+VXSMtvV
         45huDVrglTlhaODR1jjVQpWHNB5Bqvx3R8k5OVBKtAUJYRxgwfsZXss/QsWgceN6kjgE
         osesNOb5p0sWr1de2JcXw0UAEUq3goS9Nv5cEFh+oX7pV91oh/NecNnuC/ikYKkNv+du
         5f3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681332558; x=1683924558;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8hdZHKFT9Rd4RSuruBi1wtqiU0miv7QXZ4KN0K8fAoY=;
        b=dC1TYZHPa+kgYhzbRHD6fhu8AsMq8HuRT8JCW3F+Drx5BeZOHXYN5GinShaGP5iqbi
         F8w6btGXbY1zJ3CTVCMiWA1MGOqcpJ7vxjDWJwk4p0AAffkm3k6iUUjusIiTAouRiLVT
         aUVqcY/yLLO2G73oSJWvctqlucJY8OCZZFb57ug0INJoy20Pplr9O4H9BO8RVZ6k7KU+
         6IZXrpKZJswRIGb8PP1LBqIJjnycvKsSpZR6UBwip+3/DwzayzqE8BLtxbpGuswzFbb/
         IqbaRIlnqelyN3sSErBewKSHNJDmTinGEEOQL2P7HFiXbgyL29AMnj74+TbqusUy8Opi
         dIZQ==
X-Gm-Message-State: AAQBX9fus+UGlTuSdhLqRUTekqajfXx+foFuZGOCjH5SAKO7EobbYV+6
        IFfQNBe1nIREPmlC8NNutNoxfQ8948QOGMyVOvA=
X-Google-Smtp-Source: AKy350ZXyda+pFBG94hjyeZCVCNd2eLWu+gKUBNI+hJ5FxhVfVukoovOI3qFion787G+YZP/JcTDueq9oe2h37wTCaQ=
X-Received: by 2002:ac2:4570:0:b0:4ec:8c1e:c817 with SMTP id
 k16-20020ac24570000000b004ec8c1ec817mr43086lfm.10.1681332558016; Wed, 12 Apr
 2023 13:49:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:87d0:0:b0:295:a92f:ed8a with HTTP; Wed, 12 Apr 2023
 13:49:17 -0700 (PDT)
Reply-To: georgebrownhoward02@gmail.com
From:   georgebrownhoward <georgemike7030@gmail.com>
Date:   Wed, 12 Apr 2023 22:49:17 +0200
Message-ID: <CAAJyO5zXm8=7xnZRGNeT8nXOmP-y2ZeqURKZbSaVdsJ0dVRu5w@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16nXnNeV150NCg0K16nXnteZINeSJ9eV16jXkicg15HXqNeQ15XXnyDXkNeg15kg16LXldeo15og
15PXmdefINeR157Xp9em15XXoteZLiDXkNeg15kg16jXldem15Qg15zXlNem15nXoiDXnNeaDQrX
lNen16jXldeRINec15zXp9eV15cg16nXnNeZLiDXkNeq15Qg16rXmdeo16kg15DXqiDXlNeh15vX
ldedINep15wgKDguNSDXnteZ15zXmdeV158g15PXldec16gpDQrXk9eV15zXqNeZ150g16nXlNec
16fXldeXINep15zXmSDXlNep15DXmdeoINeR15HXoNenINec16TXoNeZINee15XXqteVLg0KDQrX
lNec16fXldeXINep15zXmSDXlNeV15Ag15DXlteo15cg15HXnteT15nXoNeq15og16nXnteqINeR
16rXkNeV16DXqiDXk9eo15vXmdedINei150g15DXqdeq15UNCteV15HXnyDXmdeX15nXky4g15DX
oNeZINeQ15TXmdeUINeW15vXkNeZINei150gNTAlINee16HXmiDXlNen16jXnyDXldeQ15nXnNeV
IDUwJSDXmdeU15nXlQ0K15zXlNeZ15XXqiDXkdep15HXmdec15ouDQrXkNeg15Ag16bXldeoINen
16nXqCDXotedINeU15PXldeQItecINeU16TXqNeY15kg16nXnNeZINeb15DXnyDXnNek16jXmNeZ
150g16DXldeh16TXmdedOmdlb3JnZWJyb3duaG93YXJkMDJAZ21haWwuY29tDQoNCteo15Eg16rX
ldeT15XXqiDXnteo15DXqSwNCtee16gg15In15XXqNeSJyDXkdeo15DXldefLA0K
