Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B956CFC1B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 08:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjC3G7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 02:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjC3G7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 02:59:38 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D30211C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 23:59:33 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id y184so13486199oiy.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 23:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680159573;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YDqPfUO2KdCoM2iVnyyK25N/EhSP3Lko54SKzijbLKE=;
        b=Y+zidRizzehkvn662CKV95elJl+U8soXLhE+ByWyPzppa7Rc/rAIXL9rqs8TzbZK4E
         qFePk28kj/Lu34mlw1voMcBmPc9kFA6rDbY1laBo1tHE/UYL6F2Wd2sn0eqRSo8izreH
         QgwdjCD3Jo8hgmLcOytBxZRXDqmWiJ1l78d8Ebwtp6k30AXYNLiUvgaSQ4Wtf635MzYO
         suI9yjjHbcOs7g5g76Es1VK3M73esCEDGmEr+7N1oZ6zEs15pBT2UQFwerFIeim7FniG
         HfouRH8wsdy3PiB2GzkMpeij4qV7xPyAwTpADc9vIIP5fZO0TyBxqbugx3wjS0h6JyGj
         /lww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680159573;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YDqPfUO2KdCoM2iVnyyK25N/EhSP3Lko54SKzijbLKE=;
        b=6jaZzFA6fY8koKZcYSfHQv/7p+yoNAR7IiZqBU6iXydIi+OVLqOfUfmqYpZ0WGHajU
         FIRqKoDdMWlINLXsRwAoeKBdHqVVaIyyn3C7SNyVRbhEcSWDieJsnchXs5FC1ewda+Wc
         ReqReAu5Mn0y7OTLcEsgwF0SSxA6frUk3m79zJcghz/SUeGV2xzaj3Hz8mO8I6+zUGiE
         VrQjj/7Fn2Pr2DHCPH40zWKQloz9TX6zN0xsksWdodiE1URPL+wO2OQOFl3PfjChSLSl
         y6jGigHvSADJyh1VArU1szXiqwtNNjlmAn6YFULTBNFyc9QzfXPOCsvdRpczvm1Iupjh
         pbvg==
X-Gm-Message-State: AAQBX9dfg7t1P0qpkJ1RtJbjSm3Tu+2L7r9+8q8L9m1q2aT4qeiN6rxH
        hdXwf+tAXEtHJ36KRkAtAjQYFmNV7E9yCOzzvXV0ClEw2ijwZg==
X-Google-Smtp-Source: AKy350aOdVyvPN2v5rG3tu1lcyoq01ESmgI+frUJvB5YixittxflPQR3DD6RZKjX3hsC1Nmih8m45dxSaVR7e7oju3o=
X-Received: by 2002:aca:1015:0:b0:388:240:9af7 with SMTP id
 21-20020aca1015000000b0038802409af7mr2320442oiq.0.1680159571427; Wed, 29 Mar
 2023 23:59:31 -0700 (PDT)
MIME-Version: 1.0
Sender: moonleepark60@gmail.com
Received: by 2002:a05:6358:60ce:b0:109:48d5:3678 with HTTP; Wed, 29 Mar 2023
 23:59:29 -0700 (PDT)
From:   Mrsaisha Gaddafi <mrsaishagaddafi95@gmail.com>
Date:   Thu, 30 Mar 2023 07:59:29 +0100
X-Google-Sender-Auth: GLQQefXfnXDtmuLgt18DS7wxa6Y
Message-ID: <CAFkuzN68xwvq1ncikVRraDV8B3dmhBAUSgLLHhv8LJ8vFX6EDQ@mail.gmail.com>
Subject: GREETINGS FROM AISHA GADDAFI.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        LOTS_OF_MONEY,NA_DOLLARS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm the only biological Daughter of late Libyan President  [ LATE
COLONEL MUAMMAR GADDAFI ], I'm a Widow and single Mother of three
Children  I am  currently living in Oman, , Presently,  I am  under
political Asylum protection by the Omani Government.

I have funds worth  Seven Million, Five  Hundred Thousand U.S Dollars
[ $7.500.000.00 US Dollars ] which I want to entrust to you for
investment projects in your country. If you are capable to handle this
project on my behalf, kindly reply urgently to enable me to provide
you more details to proceed the transfer process, I shall appreciate
your quick response.

You can know more through the BBC news links below:

http://www.bbc.com/news/world-africa-19966059

Thanks
Yours Faithfully
Mrs Aisha Gaddafi
