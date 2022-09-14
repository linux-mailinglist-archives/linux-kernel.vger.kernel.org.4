Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A647F5B8118
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 07:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiINFvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 01:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiINFvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 01:51:10 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A16564FE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 22:51:07 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id 29so20599731edv.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 22:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=Rzn+ELvPX5W7AGhjZtpZvYJ+aqaH/60YsBtITR2DMmc=;
        b=eSeTu+yHRHSCgq9r9iu8y9yBgx8yMxHOsD3jdLNJWTzwKZbEpJGG8qZ3u/QD1R5/uN
         zSw6mZijyn9Sj2u9vn6oyYi6BTYDeNYAz7YE36Tbpf9H/o5DU+MFTspT7obfndFiHcHY
         N4UCr/LYR1TiUzCdPundsLmAaBe/5W5s+zFwkag8A1fV4ER7NJ75GimmijznDS9xZVF9
         x8PPAFhSLr/7LOXYKX7sN8rSB9Iu/N4aN3is/8bPz6FK9V9p9iPQTNCrZeDaMs9JU4xF
         DaHGg01l/B966rbSmfGlj2GztGntnrvNNNRsvs9RzhWW+qVtgtYeg4lW8dEQvBv9P2oN
         BKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=Rzn+ELvPX5W7AGhjZtpZvYJ+aqaH/60YsBtITR2DMmc=;
        b=2tr0maRj4oNpUW/D5TDR+tpeHyNeXqfzx/utOFfFyou1lOs8RNduK8Q5qeSanW4nqJ
         Tva7IYSyD99E2fBv6e9CMRL4LjhbpgNKJxQ/hA2dgCjGynokwEoD5yHwh8Z5NVC82sf9
         GV4oqho0CFkPH+SYEyDwHWoO0fjfHanjOkh5FoBMm9NKJbgZeR0YHVrhGZtkTjse/MYv
         ZNLefEVextv2N6kkdsnZqD58kK/t6UqDTbITPiq3Cd6oqqefjDEVeETlQKuXDCubN9so
         3qshkUJe4RCtyeY/JriD95IPFeq4ktuOomkbCTA0wtyFJ2gZS818gVG1aiGHfnEkBPGb
         OUvw==
X-Gm-Message-State: ACgBeo1QWoch0XLqCNnjctPq6d2KXsH9wzMBdVR/tvP9gY8/K2to3JVB
        TY+uboYBtsNgo0/zaeMZ9LWM2WYmFSiSEJZk4Zo=
X-Google-Smtp-Source: AA6agR7CJ65ZG9PZrLmbdZYh4TYrP5+kq5fgLIk0QwZOzxMqNIudRXmG9+XsI+ZHibepeArxUrsH+cbP2wJBJruUZ0M=
X-Received: by 2002:aa7:d8d7:0:b0:44f:241d:7d81 with SMTP id
 k23-20020aa7d8d7000000b0044f241d7d81mr27007419eds.201.1663134665678; Tue, 13
 Sep 2022 22:51:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:7b10:0:b0:1d8:92d2:f7f3 with HTTP; Tue, 13 Sep 2022
 22:51:04 -0700 (PDT)
From:   ms sherry johnson <mssherryj549@gmail.com>
Date:   Wed, 14 Sep 2022 06:51:04 +0100
Message-ID: <CALyxJoMja_peq197urnOVTkTeQLU-Un5P2rOXEYrtDydo=bzHw@mail.gmail.com>
Subject: Auditor Payment File: -hl/id1033/11.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=ADVANCE_FEE_5_NEW_FRM_MNY,
        BAYES_60,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FILL_THIS_FORM,FILL_THIS_FORM_LONG,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,LOTTO_DEPT,MILLION_HUNDRED,MILLION_USD,
        MONEY_FORM,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ATTENTION PLEASE
================================================================================================================================================
In the just concluded meeting with the board of Trustees of United
Nations Organization and Representative of all the financial sectors,
The HOUSE OF LORD'S HUMANITARIAN FORUM (H.L.H.F) has taking the
responsibility to pay part of debt own to citizen's across globe but
only those that their file is submitted, We are looking into the case
of Scammed Victims and those people that their lottery winning
prize/Inheritance or Contract and award payment has been denied due to
corrupt official services,

After our mutual investigation in the recent schedule for payment of
outstanding debts incurred since 1999 to 2021, your file record was
found and your email address attached, Your payment is categorized
under SOUTH AFRICA ZONE of HOUSE OF LORD'S HUMANITARIAN FORUM
(H.L.H.F) The total sum of $5.5usd has been approved under your file
according to elect, Contact the processing/paying manager for your
direct payment of US$5.5M (five Million Five Hundred Thousand United
States Dollars),

                                                  CONTACT THE
INTERNATIONAL REMITTANCE DEPARTMENT VIA-EMAIL:
Whatssapp line +44 7418348469
E-mail: foreign_finance_affairs@hotmail.com
E-mail: orgarnizationlordshumanitarian@yandex.com
E-mail: foreign_finance@mail2expert.com
CONTACT PERSON: MRS JENNET KINGSTON BROWN INTERNATIONAL FUND REMITTING
DIRECTOR Also provide the following detail to her for immediate
release of your fund,
================================================================================================================================================
Also it is very necessary and important that you send us an e-mail
containing your vital information?? As requested below so that you
will be given an immediate response and directives on what to do next:

Full Names:
Address:
City:
Zip/Postal Code:
State:
Country:
Present Occupation:
Company Owner:
Company Name:
Gender:
Age:
Reachable Tel#/Mob:..............*No Voice Mail Service*
Fax:

THIS REQUIREMENT MUST BE PROVIDED TO HER COMPLETELY,
================================================================================================================================================
As soon as the International Remittance Department receives your
information, your US$5.5M will be Transfer to your nominated Bank
account. this payment method is set up to keep a clean slate of all
debts owned by the government and company to individuals either by
contract or award fund, we hereby plead for any inconvenient that you
might have received by any of this corrupt officials, The United
Nations Organization will not be interested in your story of not
receiving your payment if you fail to abide to this Instruction.
================================================================================================================================================
Yours Faithful,
Mr. Anderson Paul
Public Relation Officer
Strand Bridge House 138-142 Strand,
City of London,
Whatssapp line +44 7418348469
OUR REF: UNN/APXB/TF/08
http://www.una.org.uk/
IMMEDIATE PAYMENT
#:WB/PC/FMF/MIN/UN/APXB/08.
UNITED NATIONS LIAISON HEADQUARTERS UK LONDON OFFICE.

SORRY IF YOU RECEIVED THIS MESSAGE IN JUNK BOX IS DUE TO OUR SLOW NETWORK.
=============================================================
