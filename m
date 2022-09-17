Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD75A5BB7E2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 12:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiIQKlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 06:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiIQKlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 06:41:01 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9CA326DD;
        Sat, 17 Sep 2022 03:40:10 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id f20so30377471edf.6;
        Sat, 17 Sep 2022 03:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ppESI1uIffBAbAMxv1wwlCCRXUz2yUrHEc/rExHz54E=;
        b=H7eAakVd6MvVrPev6ZDvXlE3Hbh3AMJGA2nEtr+vr9/YvZiZeQO3WIBC0pu4ol9Ix/
         R2JuqyDVkoXUDDlF0Et46nCsR4Mj+R5Q2/pzqtynL2LoCVeSMdGStWlN+Glk7AJAZ1Hc
         RO1yhVWgDlDyrYBBskRmd9mHs8aWBB7Q4IuKohkIhT5AdpkBatumJ+O3Fd9L+fKxZATu
         VkmoBiqVUjmYThEkgCtHCVdaThlczrSLYB2uUx7uGG445RHYsZJzsrp9bm1UPOXAEwsM
         JwV6opy+SFGMIBMzaMWL90aX7tYgKq9X20KzdFaMsB+JHfrClyb9iBL3Kh6oyVucSNJY
         F30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ppESI1uIffBAbAMxv1wwlCCRXUz2yUrHEc/rExHz54E=;
        b=S5HRjDjhTM6e0nbuQ0a63L/Exoi2ZyYGaFVdw1sg2sDERuV0GJi/NPqlnZvesc5ngg
         4BWINfmlMa1KCHVwfudbTC+fmpQjMS+/LZUP2HVDsF0Vn8peVd0O44yfwNcWYGRP1bmo
         MfcpcZSEeUwSKhueY2mLI8bVQln+luwR/m0PyMJnOJbY8yyWBZgXpUCQCDvBWfm1smKt
         vGM5hM7+0/Wg6A/b74yxf0qaSl6qY8EWLfOCstXwUIBszix1v7a0gJFV2vpASCzDiK+5
         85Eko3onShOWqeOrXNqvmdmrEbr9t7viygPPY8dpFTeC1nQN4Q+BhzeOpF5H2fOPoZT4
         IMng==
X-Gm-Message-State: ACrzQf05N4DpQ5ckRqID1y+FW9UsGqb1lY1+Ns8FTCWG4dI8mnQwiM3X
        hXJ89+yUuFd+6/TUnchSPLCGpwpkTgStWDr8wfI=
X-Google-Smtp-Source: AMsMyM4uzSHUS/KpCinoTepsKZ3xNeCgZMb54nJPClY+hEuXAothEPFcYQgLS0QD5NMv3nhMUTuFlH1HR68gySMs5H0=
X-Received: by 2002:a05:6402:43cc:b0:451:129e:1b1e with SMTP id
 p12-20020a05640243cc00b00451129e1b1emr7367350edc.258.1663411207044; Sat, 17
 Sep 2022 03:40:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220912190753.10158-1-jagathjog1996@gmail.com>
 <20220912190753.10158-3-jagathjog1996@gmail.com> <YyHBKNC/YHbvIn40@mail.local>
In-Reply-To: <YyHBKNC/YHbvIn40@mail.local>
From:   Jagath Jog J <jagathjog1996@gmail.com>
Date:   Sat, 17 Sep 2022 16:09:54 +0530
Message-ID: <CAM+2Eu+jCA9yJma2UtD736opw0=_uCz4Zbiem89ehexTEU7mQw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rtc: maxim: Add Maxim max31329 real time clock
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     a.zummo@towertech.it, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello Alexandre,

Thank you for reviewing.

On Wed, Sep 14, 2022 at 5:25 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Hello,
>
> On 13/09/2022 00:37:53+0530, Jagath Jog J wrote:
> > +static int max31329_get_osc_status(struct device *dev)
> > +{
> > +     struct max31329_data *max31329 = dev_get_drvdata(dev);
> > +     unsigned int status;
> > +     int ret;
> > +
> > +     ret = regmap_read(max31329->regmap, MAX31329_STATUS_REG, &status);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (status & MAX31329_STATUS_OSF) {
> > +             dev_err(dev, "Oscillator has stopped\n");
>
> I would drop this message there is probably nothing specific the user
> can do once it appears in the kernel log.
>
> > +             return -EINVAL;
> > +     }
> > +     return 0;
> > +}
> > +
> > +static int max31329_alarm_irq_enable(struct device *dev, unsigned int enable)
> > +{
> > +     struct max31329_data *max31329 = dev_get_drvdata(dev);
> > +
> > +     return regmap_update_bits(max31329->regmap, MAX31329_INT_EN_REG,
> > +                               MAX31329_INT_EN_A1IE,
> > +                               enable ? MAX31329_INT_EN_A1IE : 0);
> > +}
> > +
> > +static int max31329_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
> > +{
> > +     struct max31329_data *max31329 = dev_get_drvdata(dev);
> > +     struct rtc_time *const tm = &alarm->time;
> > +     unsigned int aie_en, aie_flag;
> > +     int ret;
> > +     u8 regs[6];
> > +
> > +     ret = max31329_get_osc_status(dev);
> > +     if (ret)
> > +             return ret;
> > +
>
> The oscillator being stopped doesn't mean the alarm is not correct so
> you don't need to check here.

Sure, I will remove this check.

>
> > +     ret = regmap_bulk_read(max31329->regmap, MAX31329_ALM1_SEC_REG, regs,
> > +                            MAX31329_ALM1_SEC_LEN);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = regmap_read(max31329->regmap, MAX31329_INT_EN_REG, &aie_en);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = regmap_read(max31329->regmap, MAX31329_STATUS_REG, &aie_flag);
> > +     if (ret)
> > +             return ret;
> > +
> > +     tm->tm_sec = bcd2bin(regs[REG_TO_OFFSET(MAX31329_SECONDS_REG)] & 0x7f);
> > +     tm->tm_min = bcd2bin(regs[REG_TO_OFFSET(MAX31329_MINUTES_REG)] & 0x7f);
> > +     tm->tm_hour = bcd2bin(regs[REG_TO_OFFSET(MAX31329_HOURS_REG)] & 0x3f);
> > +     tm->tm_mday = bcd2bin(regs[REG_TO_OFFSET(MAX31329_DATE_REG) - 1] & 0x3f);
> > +     tm->tm_mon = bcd2bin(regs[REG_TO_OFFSET(MAX31329_MONTH_REG) - 1] &
> > +                          0x1f) - 1;
> > +     tm->tm_year = bcd2bin(regs[REG_TO_OFFSET(MAX31329_YEAR_REG) - 1]) + 200;
> > +
> > +     alarm->enabled = FIELD_GET(MAX31329_INT_EN_A1IE, aie_en);
> > +     alarm->pending = FIELD_GET(MAX31329_STATUS_A1F, aie_flag) &&
> > +                                alarm->enabled;
> > +
> > +     return 0;
> > +}
> > +
> > +static int max31329_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
> > +{
> > +     struct max31329_data *max31329 = dev_get_drvdata(dev);
> > +     const struct rtc_time *tm = &alrm->time;
> > +     u8 regs[6], year;
> > +     int ret;
> > +
> > +     ret = max31329_get_osc_status(dev);
> > +     if (ret)
> > +             return ret;
>
> It is fine to set the alarm while the oscillator is stopped. The usual
> userspace tools will anyway prevent you from doing that because they
> first read the time and that call will check.
>
> > +
> > +     regs[REG_TO_OFFSET(MAX31329_SECONDS_REG)] = bin2bcd(tm->tm_sec) & 0x7F;
> > +     regs[REG_TO_OFFSET(MAX31329_MINUTES_REG)] = bin2bcd(tm->tm_min) & 0x7f;
> > +     regs[REG_TO_OFFSET(MAX31329_HOURS_REG)] = bin2bcd(tm->tm_hour) & 0x3f;
> > +     regs[REG_TO_OFFSET(MAX31329_DATE_REG) - 1] = bin2bcd(tm->tm_mday) & 0x3f;
> > +     regs[REG_TO_OFFSET(MAX31329_MONTH_REG) - 1] = bin2bcd(tm->tm_mon + 1) & 0x1f;
> > +
> > +     if (tm->tm_year >= 200)
> > +             year = bin2bcd(tm->tm_year - 200);
> > +     else
> > +             year = bin2bcd(tm->tm_year - 100);
>
> This doesn't feel right, doesn't that break start-year?
>
> What is the actual time range supported by this RTC? Shouldn't you set
> the century?

The time range supported by RTC is 2000 to 2199.
The alarm registers don't have a century bit.
I have tested the alarm for
2122-09-17T01:22:00
2142-09-17T01:22:00
2160-02-29T00:00:00
2196-02-29T00:00:00 etc

I will add another condition such that if the century bit
from the time register is not set then configuring the
alarm for the next century is not allowed.
...
        if (tm->tm_year >= 200) {
                year = bin2bcd(tm->tm_year - 200);
                ret = regmap_read(max31329->regmap, MAX31329_MONTH_REG, &month);
                if (ret)
                        return ret;

                if (!FIELD_GET(MAX31329_MONTH_CENTURY, month))
                        return -EINVAL;
        } else {
                year = bin2bcd(tm->tm_year - 100);
         }
...
>
> > +     regs[REG_TO_OFFSET(MAX31329_YEAR_REG) - 1] = year;
> > +
> > +     ret = regmap_bulk_write(max31329->regmap, MAX31329_ALM1_SEC_REG, regs,
> > +                             MAX31329_ALM1_SEC_LEN);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return max31329_alarm_irq_enable(dev, alrm->enabled);
> > +}
> > +
> > +static int max31329_read_time(struct device *dev, struct rtc_time *tm)
> > +{
> > +     struct max31329_data *max31329 = dev_get_drvdata(dev);
> > +     u8 data[7], century = 0;
> > +     int ret;
> > +
> > +     ret = max31329_get_osc_status(dev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = regmap_bulk_read(max31329->regmap, MAX31329_SECONDS_REG, data,
> > +                            sizeof(data));
> > +     if (ret)
> > +             return ret;
> > +
> > +     tm->tm_sec = bcd2bin(data[REG_TO_OFFSET(MAX31329_SECONDS_REG)] & 0x7f);
> > +     tm->tm_min = bcd2bin(data[REG_TO_OFFSET(MAX31329_MINUTES_REG)] & 0x7f);
> > +     tm->tm_hour = bcd2bin(data[REG_TO_OFFSET(MAX31329_HOURS_REG)] & 0x3f);
> > +     /* Day of the week in linux range is 0~6 while 1~7 in RTC chip */
> > +     tm->tm_wday = bcd2bin(data[REG_TO_OFFSET(MAX31329_DAY_REG)] & 0x07) - 1;
> > +     tm->tm_mday = bcd2bin(data[REG_TO_OFFSET(MAX31329_DATE_REG)] & 0x3f);
> > +     /* linux tm_mon range:0~11, while month range is 1~12 in RTC chip */
> > +     tm->tm_mon = bcd2bin(data[REG_TO_OFFSET(MAX31329_MONTH_REG)] & 0x1f) - 1;
> > +
> > +     century = data[REG_TO_OFFSET(MAX31329_MONTH_REG)] & MAX31329_MONTH_CENTURY;
> > +     tm->tm_year = bcd2bin(data[REG_TO_OFFSET(MAX31329_YEAR_REG)]) +
> > +                          (century ? 200 : 100);
> > +
> > +     return 0;
> > +}
> > +
> > +static int max31329_set_time(struct device *dev, struct rtc_time *tm)
> > +{
> > +     struct max31329_data *max31329 = dev_get_drvdata(dev);
> > +     u8 regs[7];
> > +     int ret;
> > +
> > +     ret = max31329_get_osc_status(dev);
> > +     if (ret)
> > +             return ret;
> > +
>
> Checking the oscillator is not needed here but resetting the status is.

Resetting the device will resets the digital block,
I2C-programmable registers and oscillator also,
The oscillator is taking some time around 80 milli sec
to be back as usual.

Is it required to reset every time during the time setting?

>
> > +     regs[REG_TO_OFFSET(MAX31329_SECONDS_REG)] = bin2bcd(tm->tm_sec);
> > +     regs[REG_TO_OFFSET(MAX31329_MINUTES_REG)] = bin2bcd(tm->tm_min);
> > +     regs[REG_TO_OFFSET(MAX31329_HOURS_REG)] = bin2bcd(tm->tm_hour);
> > +     regs[REG_TO_OFFSET(MAX31329_DAY_REG)] = bin2bcd(tm->tm_wday + 1);
> > +     regs[REG_TO_OFFSET(MAX31329_DATE_REG)] = bin2bcd(tm->tm_mday);
> > +     regs[REG_TO_OFFSET(MAX31329_MONTH_REG)] = bin2bcd(tm->tm_mon + 1);
> > +
> > +     if (tm->tm_year >= 200)
> > +             regs[REG_TO_OFFSET(MAX31329_MONTH_REG)] |= MAX31329_MONTH_CENTURY;
> > +     regs[REG_TO_OFFSET(MAX31329_YEAR_REG)] = bin2bcd(tm->tm_year % 100);
> > +
> > +     return regmap_bulk_write(max31329->regmap, MAX31329_SECONDS_REG, regs,
> > +                              MAX31329_WATCH_SEC_LEN);
> > +}
> > +
> > +static const struct rtc_class_ops max31329_rtc_ops = {
> > +     .read_time = max31329_read_time,
> > +     .set_time = max31329_set_time,
> > +     .read_alarm = max31329_read_alarm,
> > +     .set_alarm = max31329_set_alarm,
> > +     .alarm_irq_enable = max31329_alarm_irq_enable,
> > +};
> > +
> > +static irqreturn_t max31329_irq_handler(int irq, void *dev_id)
> > +{
> > +     struct device *dev = dev_id;
> > +     struct max31329_data *max31329 = dev_get_drvdata(dev);
> > +     unsigned int flags, controls;
> > +     unsigned long events = 0;
> > +     int ret;
> > +
> > +     ret = regmap_read(max31329->regmap, MAX31329_INT_EN_REG, &controls);
> > +     if (ret) {
> > +             dev_warn(dev, "Read IRQ control register error %d\n", ret);
>
> Drop all of those messages please.

Sure I will drop all messages.

>
> > +             return IRQ_NONE;
> > +     }
> > +
> > +     ret = regmap_read(max31329->regmap, MAX31329_STATUS_REG, &flags);
> > +     if (ret) {
> > +             dev_warn(dev, "Read IRQ flags register error %d\n", ret);
> > +             return IRQ_NONE;
> > +     }
> > +
> > +     if (flags & MAX31329_STATUS_A1F) {
> > +             flags &= ~MAX31329_STATUS_A1F;
> > +             controls &= ~MAX31329_INT_EN_A1IE;
> > +             events = RTC_AF | RTC_IRQF;
> > +     }
> > +
> > +     if (events) {
> > +             rtc_update_irq(max31329->rtc, 1, events);
> > +             regmap_write(max31329->regmap, MAX31329_STATUS_REG, flags);
> > +             regmap_write(max31329->regmap, MAX31329_INT_EN_REG, controls);
> > +             return IRQ_HANDLED;
> > +     }
> > +
> > +     return IRQ_NONE;
> > +}
> > +
> > +static void max31329_trickle_config(struct device *dev)
> > +{
> > +     struct max31329_data *max31329 = dev_get_drvdata(dev);
> > +     u8 trickle_reg;
> > +     int ret, i;
> > +     u32 ohms;
> > +
> > +     /* Configure the trickle charger. */
> > +     ret = device_property_read_u32(dev, "trickle-resistor-ohms", &ohms);
> > +     if (ret)
> > +             return;
> > +
> > +     trickle_reg = MAX31329_TRICKLE_EN;
> > +     for (i = 1; i <= ARRAY_SIZE(max31329_trickle_ohms); i++) {
> > +             if (max31329_trickle_ohms[i - 1] == ohms) {
> > +                     trickle_reg |= i;
> > +                     regmap_write(max31329->regmap, MAX31329_TRICKLE_REG,
> > +                                  trickle_reg);
> > +             }
> > +     }
> > +}
> > +
> > +static int max31329_nvram_write(void *priv, unsigned int offset, void *val,
> > +                             size_t bytes)
> > +{
> > +     struct regmap *max31329_regmap = (struct regmap *)priv;
> > +
> > +     return regmap_bulk_write(max31329_regmap,
> > +                              MAX31329_RAM0_START_REG + offset,
> > +                              val, bytes);
> > +}
> > +
> > +static int max31329_nvram_read(void *priv, unsigned int offset, void *val,
> > +                            size_t bytes)
> > +{
> > +     struct regmap *max31329_regmap = (struct regmap *)priv;
> > +
> > +     return regmap_bulk_read(max31329_regmap,
> > +                             MAX31329_RAM0_START_REG + offset,
> > +                             val, bytes);
> > +}
> > +
> > +#ifdef CONFIG_COMMON_CLK
> > +#define clkout_hw_to_max31329(hw) container_of(hw, struct max31329_data, clkout_hw)
> > +
> > +static int clkout_rates[] = {
> > +     1,
> > +     4096,
> > +     8192,
> > +     32768
> > +};
> > +
> > +static unsigned long max31329_clkout_recalc_rate(struct clk_hw *hw,
> > +                                              unsigned long parent_rate)
> > +{
> > +     struct max31329_data *max31329 = clkout_hw_to_max31329(hw);
> > +     int clkout, ret;
> > +
> > +     ret = regmap_read(max31329->regmap, MAX31329_RTC_CONFIG2_REG, &clkout);
> > +     if (ret)
> > +             return 0;
> > +
> > +     return clkout_rates[FIELD_GET(MAX31329_RTC_CFG2_CLKOHZ_MSK, clkout)];
> > +}
> > +
> > +static long max31329_clkout_round_rate(struct clk_hw *hw, unsigned long rate,
> > +                                    unsigned long *prate)
> > +{
> > +     int i;
> > +
> > +     for (i = 0; i < ARRAY_SIZE(clkout_rates); i++)
> > +             if (clkout_rates[i] >= rate)
> > +                     return clkout_rates[i];
> > +
> > +     return 0;
> > +}
> > +
> > +static int max31329_clkout_set_rate(struct clk_hw *hw, unsigned long rate,
> > +                                 unsigned long parent_rate)
> > +{
> > +     struct max31329_data *max31329 = clkout_hw_to_max31329(hw);
> > +     int i;
> > +
> > +     for (i = 0; i < ARRAY_SIZE(clkout_rates); i++)
> > +             if (rate == clkout_rates[i])
> > +                     return regmap_update_bits(max31329->regmap,
> > +                                               MAX31329_RTC_CONFIG2_REG,
> > +                                               MAX31329_RTC_CFG2_CLKOHZ_MSK,
> > +                                               FIELD_PREP(MAX31329_RTC_CFG2_CLKOHZ_MSK,
> > +                                                          i));
> > +     return -EINVAL;
> > +}
> > +
> > +static int max31329_clkout_prepare(struct clk_hw *hw)
> > +{
> > +     struct max31329_data *max31329 = clkout_hw_to_max31329(hw);
> > +
> > +     return regmap_update_bits(max31329->regmap, MAX31329_RTC_CONFIG2_REG,
> > +                               MAX31329_RTC_CONFIG2_ENCLKO,
> > +                               MAX31329_RTC_CONFIG2_ENCLKO);
> > +}
> > +
> > +static void max31329_clkout_unprepare(struct clk_hw *hw)
> > +{
> > +     struct max31329_data *max31329 = clkout_hw_to_max31329(hw);
> > +
> > +     regmap_update_bits(max31329->regmap, MAX31329_RTC_CONFIG2_REG,
> > +                        MAX31329_RTC_CONFIG2_ENCLKO,
> > +                        FIELD_PREP(MAX31329_RTC_CONFIG2_ENCLKO, 0));
> > +}
> > +
> > +static int max31329_clkout_is_prepared(struct clk_hw *hw)
> > +{
> > +     struct max31329_data *max31329 = clkout_hw_to_max31329(hw);
> > +     int clkout, ret;
> > +
> > +     ret = regmap_read(max31329->regmap, MAX31329_RTC_CONFIG2_REG, &clkout);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return !!(clkout & MAX31329_RTC_CONFIG2_ENCLKO);
> > +}
> > +
> > +static const struct clk_ops max31329_clkout_ops = {
> > +     .prepare = max31329_clkout_prepare,
> > +     .unprepare = max31329_clkout_unprepare,
> > +     .is_prepared = max31329_clkout_is_prepared,
> > +     .recalc_rate = max31329_clkout_recalc_rate,
> > +     .round_rate = max31329_clkout_round_rate,
> > +     .set_rate = max31329_clkout_set_rate,
> > +};
> > +
> > +static int max31329_clkout_register_clk(struct max31329_data *max31329,
> > +                                     struct i2c_client *client)
> > +{
> > +     struct device_node *node = client->dev.of_node;
> > +     struct clk_init_data init;
> > +     struct clk *clk;
> > +
> > +     init.name = "max31329-clkout";
> > +     init.ops = &max31329_clkout_ops;
> > +     init.flags = 0;
> > +     init.parent_names = NULL;
> > +     init.num_parents = 0;
> > +     max31329->clkout_hw.init = &init;
> > +
> > +     /* optional override of the clockname */
> > +     of_property_read_string(node, "clock-output-names", &init.name);
> > +
> > +     clk = devm_clk_register(&client->dev, &max31329->clkout_hw);
> > +     if (!IS_ERR(clk))
> > +             of_clk_add_provider(node, of_clk_src_simple_get, clk);
> > +
> > +     return PTR_ERR(clk);
> > +}
> > +#endif
> > +
> > +static int max31329_probe(struct i2c_client *client,
> > +                       const struct i2c_device_id *id)
> > +{
> > +     struct max31329_data *max31329;
> > +     int ret;
> > +     struct nvmem_config nvmem_cfg = {
> > +             .name = "max31329_nvram",
> > +             .word_size = 1,
> > +             .stride = 1,
> > +             .size = 64,
> > +             .type = NVMEM_TYPE_BATTERY_BACKED,
> > +             .reg_read = max31329_nvram_read,
> > +             .reg_write = max31329_nvram_write,
> > +     };
> > +
> > +     max31329 = devm_kzalloc(&client->dev, sizeof(*max31329), GFP_KERNEL);
> > +     if (!max31329)
> > +             return -ENOMEM;
> > +
> > +     max31329->regmap = devm_regmap_init_i2c(client, &config);
> > +     if (IS_ERR(max31329->regmap)) {
> > +             dev_err(&client->dev, "regmap init failed\n");
> > +             return PTR_ERR(max31329->regmap);
> > +     }
> > +
> > +     dev_set_drvdata(&client->dev, max31329);
> > +
> > +     max31329->rtc = devm_rtc_allocate_device(&client->dev);
> > +     if (IS_ERR(max31329->rtc))
> > +             return PTR_ERR(max31329->rtc);
> > +
> > +     max31329->rtc->ops = &max31329_rtc_ops;
> > +     max31329->irq = client->irq;
> > +     max31329->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
> > +     max31329->rtc->range_max = RTC_TIMESTAMP_END_2199;
> > +
> > +     if (max31329->irq) {
> > +             ret = devm_request_threaded_irq(&client->dev, max31329->irq,
> > +                                             NULL, max31329_irq_handler,
> > +                                             IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> > +                                             "max31329", &client->dev);
> > +             if (ret) {
> > +                     dev_err(&client->dev, "unable to request IRQ\n");
>
> This message can be dropped.
>
> > +                     return ret;
> > +             }
> > +
> > +             ret = regmap_write(max31329->regmap, MAX31329_RTC_CONFIG2_REG,
> > +                                MAX31329_RTC_CONFIG2_ENCLKO);
>
> Can you explain what this does because if you are changing a default
> register value, we will be stuck with that forever and I feel like this
> is something that should be configurable.

Yeah, I missed this, I shouldn't have set this as default.
I will remove this since it is already configurable in _clkout_prepare and
_clkout_unprepare.


>
> > +             if (ret) {
> > +                     dev_err(&client->dev, "unable to configure INT pin");
> > +                     return ret;
> > +             }
> > +
> > +             if (device_property_read_bool(&client->dev, "wakeup-source"))
> > +                     device_init_wakeup(&client->dev, true);
>
> wakeup-source should be used when no interrupt is available. When there
> is a interrupt, we assume the RTC can wake up the device.
>
> > +     } else {
> > +             clear_bit(RTC_FEATURE_ALARM, max31329->rtc->features);
> > +             clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, max31329->rtc->features);
> > +     }
> > +
> > +     ret = devm_rtc_register_device(max31329->rtc);
> > +     if (ret)
> > +             return ret;
> > +
> > +     max31329_trickle_config(&client->dev);
> > +
> > +     nvmem_cfg.priv = max31329->regmap;
> > +     devm_rtc_nvmem_register(max31329->rtc, &nvmem_cfg);
> > +
> > +#ifdef CONFIG_COMMON_CLK
> > +     max31329_clkout_register_clk(max31329, client);
> > +#endif
> > +
> > +     return 0;
> > +}
> > +
> > +static const __maybe_unused struct of_device_id max31329_of_match[] = {
> > +     { .compatible = "maxim,max31329", },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(of, max31329_of_match);
> > +
> > +static struct i2c_driver max31329_driver = {
> > +     .driver = {
> > +             .name = "rtc-max31329",
> > +             .of_match_table = of_match_ptr(max31329_of_match),
> > +     },
> > +     .probe = max31329_probe,
> > +};
> > +module_i2c_driver(max31329_driver);
> > +
> > +MODULE_AUTHOR("Jagath Jog J <jagathjog1996@gmail.com>");
> > +MODULE_DESCRIPTION("Maxim MAX31329 RTC driver");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.17.1
> >
>
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
